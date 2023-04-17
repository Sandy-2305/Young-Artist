<script setup lang="ts">
import axios from 'axios';
import { ref, reactive, computed, onMounted } from 'vue'
import BuyTicket_NormalProcess from './BuyTicket_NormalProcess.vue'
import type { ticketOrderInterface } from '@/types/TicketOrderInterface'
import type { seatInterface } from '@/types/SeatInterface';
import { useRouter, onBeforeRouteLeave, onBeforeRouteUpdate } from 'vue-router';
import { CustomerStore } from '@/stores/CustomerStore';
import { EventStore } from '@/stores/EventStore';
import type { PaymentInterface } from '@/types/PaymentInterface';
import { ElMessage, ElMessageBox } from 'element-plus'


const customerData = CustomerStore().customerData
const eventData = EventStore().cardData
const props = defineProps(["seatData", "eventId"])
const router = useRouter();


const OrderPrice = ref(0)

// 計算訂單價格
const calOrderPrice = computed(() => {
    if (props.seatData.length == 0) {
        OrderPrice.value = 0
    } else {
        let TicketTotalPrice = 0
        props.seatData.forEach((item: seatInterface, index: number) => {
            const count = item.count === undefined ? 0 : item.count
            const price = item.price === undefined ? 0 : item.price

            TicketTotalPrice += price * count
        });
        OrderPrice.value = TicketTotalPrice
    }

    return OrderPrice.value
})

// 流程步驟
const processStep = ref(1);

onBeforeRouteLeave((to, from, next) => {
    if (processStep.value == 2) {
        if (directCancelBtn.value) {
            directleaveTicketOrder();
            next()
            return ""
        } else {
            leaveTicketOrder(next)
        }
    } else if (processStep.value == 3) {
        next()
    }
})

onBeforeRouteUpdate((to, from, next) => {
    if (processStep.value == 2) {
        leaveTicketOrder(next)
    } else {
        next()
    }
})

//  重新整理取消訂單
onMounted(() => {
    if (localStorage.getItem("orderCheckProcess") != null) {
        ReupdateTicketOrder(localStorage.getItem("orderCheckProcess"))
        localStorage.removeItem("orderCheckProcess")
    }
})

// 訂單資訊
const OrderInfo: any = reactive([])
const TicketOrderUrl = "https://localhost:44393/api/TicketOrders";
const TicketOrderDetailUrl = "https://localhost:44393/api/TicketOrders/detail"
const OrderId = ref(0)
const OrderInfo_step2 = reactive<ticketOrderInterface[]>([])
const btnText = ref("下一步");
const nextStep = async () => {
    switch (processStep.value) {
        case 1:
            ElMessageBox.confirm(
                '確定好數量了嗎?',
                '再次確認',
                {
                    confirmButtonText: '前往下一步',
                    cancelButtonText: '關閉',
                    type: 'warning',
                }
            )
                .then(async () => {
                    processStep.value += 1;
                    props.seatData.forEach((item: seatInterface, index: number) => {
                        const count = item.count === undefined ? 0 : item.count
                        if (count > 0) {
                            OrderInfo.push(item)
                        }
                    })
                    console.log(OrderInfo);
                    await axios.post(`${TicketOrderUrl}`, {
                        "OrderInfo": OrderInfo,
                        "OrderPrice": OrderPrice.value,
                        "EventId": props.eventId,
                        "CustomerId": customerData[0].customerId
                    })
                        .then(response => {
                            console.log(response);
                            OrderId.value = response.data
                            console.log(OrderId.value);
                        })
                        .catch(err => {
                            console.log("錯誤");
                        })
                    await axios
                        .get(`${TicketOrderDetailUrl}/${OrderId.value}`)
                        .then(response => {
                            console.log(response);
                            OrderInfo_step2.splice(0, response.data, ...response.data)
                            console.log(OrderInfo_step2);
                            // 查找seatData中區與價格
                            OrderInfo_step2.forEach((item, index: number) => {
                                const matchingSeatData = props.seatData.find((seat: seatInterface) => seat.area === item.area);
                                if (matchingSeatData) {
                                    OrderInfo_step2[index] = { ...item, price: matchingSeatData.price };
                                } else {
                                    OrderInfo_step2[index] = { ...item, price: 0 };
                                }
                            });
                            localStorage.setItem("orderCheckProcess", `${OrderId.value}`)
                            goToPay();
                            btnText.value = "確定下單";
                        })
                        .catch(err => {
                            console.log("錯誤");
                        })

                })
                .catch(() => {

                })

            break;
        case 2:
            ElMessageBox.confirm(
                '將前往下一步，確定個人資料了嗎?',
                '再次確認',
                {
                    confirmButtonText: '確定，生成訂單',
                    cancelButtonText: '關閉',
                    type: 'warning',
                }
            ).then(() => {
                processStep.value += 1;
                localStorage.removeItem("orderCheckProcess")
                btnSuccess();
            })
            break;
    }
}


// 加減按鈕
const minusstock = (index: number) => {
    props.seatData[index].count -= 1;
}
const plusstock = (index: number) => {
    props.seatData[index].count += 1;
}
// 計算總數量 (避免0物件訂單)
const calTotalCount = computed(() => {
    let TotalCount = 0
    props.seatData.forEach((item: seatInterface, index: number) => {
        const count = item.count === undefined ? 0 : item.count
        TotalCount += count
    })
    return TotalCount
})
// 直接按鈕取消
const directCancelBtn = ref(false);


const cancelTicketOrder = async () => {
    ElMessageBox.confirm(
        '確定取消此筆訂單嗎?',
        '再次確認',
        {
            confirmButtonText: '確定取消',
            cancelButtonText: '關閉',
            type: 'warning',
        }
    )
        .then(async () => {
            await axios.post(`https://localhost:44393/api/TicketOrders/CancelTicketOrder/${OrderId.value}`, { "OrderId": OrderId.value })
                .then(res => {
                    console.log(res)
                    directCancelBtn.value = true;
                    router.push(`/EventDetailView/${props.eventId}`)
                    btnText.value = "下一步"
                })
                .catch(err => console.log(err));
            ElMessage({
                type: 'success',
                message: '已取消訂單',
            })

        })
        .catch(() => {

        })
}
// 重整取消
const ReupdateTicketOrder = async (OrderId: any) => {
    await axios.post(`https://localhost:44393/api/TicketOrders/CancelTicketOrder/${OrderId}`, { "OrderId": OrderId })
        .then(res => {
            btnText.value = "下一步"

            console.log(res)
            router.push(`/EventDetailView/${props.eventId}`)
        })
        .catch(err => console.log(err));
}

const leaveTicketOrder = async (next) => {
    await ElMessageBox.confirm(
        '確定要離開此網頁嗎？\n\n訂單將不會完成?',
        '再次確認',
        {
            confirmButtonText: '確定取消',
            cancelButtonText: '關閉',
            type: 'warning',
        }
    ).then(async () => {
        await axios.post(`https://localhost:44393/api/TicketOrders/CancelTicketOrder/${OrderId.value}`, { "OrderId": OrderId.value })
            .then(res => {
                console.log(res)
                btnText.value = "下一步"
                processStep.value = 1;
                // router.push(`/EventDetailView/${props.eventId}`)
                next();
            })
            .catch(err => console.log(err));
    })

}
const directleaveTicketOrder = async () => {

    await axios.post(`https://localhost:44393/api/TicketOrders/CancelTicketOrder/${OrderId.value}`, { "OrderId": OrderId.value })
        .then(res => {
            console.log(res)
            processStep.value = 1;
            router.push(`/EventDetailView/${props.eventId}`)
        })
        .catch(err => console.log(err));

}

let returnOBJ: PaymentInterface;
const goToPay = () => {
    axios.post("https://localhost:44393/api/TicketOrders/GetCheckValue", {
        OrderId: `${OrderId.value}`,
        Amt: `${OrderPrice.value}`,
        ItemDesc: `${eventData[0].eventName}票券`,
        TradeDesc: `${eventData[0].eventName}票券`,
        Email: `${customerData[0].customerEmail}`,
        eventId: `${eventData[0].eventId}`
    })
        .then(res => {
            console.log(res.data)
            returnOBJ = res.data
            console.log(returnOBJ);
            localStorage.setItem("paymentOrderId", `${OrderId.value}`)
        })
        .catch(err => {
            console.log(err)
        })

}
const myForm: any = ref(null)
const goTO = () => {
    myForm.value.submit();
}

const btnSuccess = () => {
    ElMessage({
        message: '完成下單，可至會員中心查看票券訂單',
        type: 'success',
    })
}
</script>

<template>
    <el-card id="ContextBox">
        <div id="eventInfoBox" v-if="processStep == 1">
            <template v-if="eventData.length">
                <h1>{{ eventData[0].eventName }}</h1>
                <p>開始時間&nbsp&nbsp&nbsp&nbsp&nbsp{{ eventData[0].eventStartTimestamp }}</p>
                <p>活動地點&nbsp&nbsp&nbsp&nbsp&nbsp{{ eventData[0].eventLocationName }}</p>
                <p>主辦單位&nbsp&nbsp&nbsp&nbsp&nbsp{{ eventData[0].companyName }}</p>
                <p>票券種類&nbsp&nbsp&nbsp&nbsp&nbsp{{ eventData[0].eventTypeName }}</p>
            </template>
        </div>
        <BuyTicket_NormalProcess :processStep="processStep" />
        <el-card v-if="processStep == 1">
            <el-table :data="props.seatData">
                <el-table-column prop="area" label="票券種類"></el-table-column>
                <el-table-column prop="price" label="價錢"></el-table-column>
                <el-table-column prop="count">
                    <template #default="scope">
                        <div>

                            <el-button @click="minusstock(scope.$index)" :disabled="scope.row.count < 1"
                                type="primary">-</el-button>
                            <el-input type="text" v-model="scope.row.count" style="max-width:50px;" class="text-center"
                                id="inputstock" />
                            <el-button @click="plusstock(scope.$index)"
                                :disabled="scope.row.count >= scope.row.stock || scope.row.count > 4"
                                type="primary">+</el-button>
                        </div>
                    </template>
                </el-table-column>
            </el-table>
        </el-card>
        <p id="OrderPrice" v-if="processStep == 1">訂單總價 : <strong>{{ calOrderPrice }}</strong> (元)</p>
        <el-row id="customerInfoBox" v-if="processStep == 2">
            <el-col :span="1"></el-col>
            <el-col :span="22">
                <el-card id="OrderCard">
                    <el-button v-if="processStep == 2" @click="cancelTicketOrder()" id="BtnCancel">取消訂單</el-button>
                    <div>
                        <h1 style="text-align: center;">請確認訂單內容</h1>
                    </div>
                    <h2>訂單個人資訊</h2>
                    <el-card>
                        <p>訂購人姓名 : {{ customerData[0].customerName }}</p>
                        <p>訂購人電話 : {{ customerData[0].customerPhone }}</p>
                        <p>訂購人信箱 : {{ customerData[0].customerEmail }}</p>
                    </el-card>
                    <h2>訂單內容</h2>
                    <ul v-for="(item, index) in OrderInfo_step2" :key="item.orderId">
                        <el-card>
                            <li>
                                <h4>票券 ({{ index + 1 }})</h4>
                            </li>
                            <li>活動名稱 : {{ eventData[0].eventName }}</li>
                            <li>座位區 : {{ item.area }}-{{ item.seatId }}</li>
                            <li>價格 : {{ item.price }} (元)</li>
                        </el-card>
                    </ul>
                    <h2>訂單總價 : <strong>{{ OrderPrice }}</strong> (元) </h2>
                </el-card>
            </el-col>
            <el-col :span="1"></el-col>
        </el-row>
        <el-row id="payInfo" v-if="processStep == 3">
            <el-col :span="1"></el-col>
            <el-col :span="22">
                <el-card id="OrderCard">
                    <h1>請前往付款</h1>
                    <el-card>
                        <p>訂單編號 : <strong>{{ OrderId }}</strong></p>
                        <p>訂購人姓名 : {{ customerData[0].customerName }}</p>
                        <p>訂購人電話 : {{ customerData[0].customerPhone }}</p>
                        <p>訂購人信箱 : {{ customerData[0].customerEmail }}</p>
                        <p>訂單總價 : {{ OrderPrice }} (元) </p>
                        <form ref="myForm" action='https://payment-stage.ecpay.com.tw/Cashier/AioCheckOut/V5' method='post'>
                            <input type='hidden' name='MerchantID' v-model="returnOBJ.MerchantID" />
                            <input type='hidden' name='MerchantTradeNo' v-model='returnOBJ.MerchantTradeNo' />
                            <input type='hidden' name='MerchantTradeDate' v-model='returnOBJ.MerchantTradeDate' />
                            <input type='hidden' name='PaymentType' v-model="returnOBJ.PaymentType" />
                            <input type='hidden' name='TotalAmount' v-model='returnOBJ.TotalAmount' />
                            <input type='hidden' name='TradeDesc' v-model='returnOBJ.TradeDesc' />
                            <input type='hidden' name='ItemName' v-model="returnOBJ.ItemName" />
                            <input type='hidden' name='ChoosePayment' v-model='returnOBJ.ChoosePayment' />
                            <input type='hidden' name='ExpireDate' v-model='returnOBJ.ExpireDate' />
                            <input type='hidden' name='IgnorePayment' v-model="returnOBJ.IgnorePayment" />
                            <input type='hidden' name='EncryptType' v-model='returnOBJ.EncryptType' />
                            <input type='hidden' name='ReturnURL' v-model='returnOBJ.ReturnURL' />
                            <input type='hidden' name='OrderResultURL' v-model='returnOBJ.OrderResultURL' />
                            <input type='hidden' name='ClientRedirectURL' v-model='returnOBJ.ClientRedirectURL' />
                            <input type='hidden' name='PaymentInfoURL' v-model='returnOBJ.PaymentInfoURL' />
                            <input type='hidden' name='Email' v-model="returnOBJ.Email" />
                            <input type='hidden' name='CustomField2' v-model='returnOBJ.CustomField2' />
                            <input type='hidden' name='CustomField3' v-model='returnOBJ.CustomField3' />
                            <input type='hidden' name='CustomField4' v-model='returnOBJ.CustomField4' />
                            <input type='hidden' name='CheckMacValue' v-model='returnOBJ.CheckMacValue' />
                        </form>
                        <div id="BtnGoToPayBox">
                            <el-button type="primary" @click="goTO()" id="BtnGoToPay">前往付款</el-button>
                        </div>
                        <!-- <button type="submit" form="payForm">送出</button> -->
                    </el-card>
                </el-card>
            </el-col>
            <el-col :span="1"></el-col>
        </el-row>
        <div id="btnBox">
            <el-button @click="nextStep" v-if="processStep != 3" id="btnNext" :disabled="calTotalCount == 0"
                :class="{ el_button_disable: calTotalCount == 0 }" :plain="true">{{ btnText }}</el-button>
        </div>
    </el-card>
</template>

<style scoped lang="less">
@Button-Color : rgb(64, 158, 255);

.el_button_disable {
    opacity: 0.7;
}

.el-button {
    @media screen and (max-width:768px) {
        width: 5vw;
        height: 5vh;
        padding: 0;
    }
}

#BtnGoToPayBox {
    display: flex;
    justify-content: center;

    #BtnGoToPay {
        width: 10vw;

        @media screen and (max-width:768px) {
            width: 20vw;
        }
    }
}


#BtnCancel {
    width: auto;
}

.el-input {
    @media screen and (max-width:768px) {
        width: 8vw;
        height: 5vh;
    }
}

#ContextBox {
    width: 100%;

    #btnBox {
        display: flex;
        justify-content: center;
        height: 5vh;

        #btnNext {
            width: 50%;
            color: white;
            border: 0;
            background-color: @Button-Color;
            border-bottom: rgb(89, 171, 33) solid 1px;

        }

        #btnNext:hover {
            filter: brightness(0.9);
        }
    }
}

#customerInfoBox {
    margin-bottom: 15vh;

}

.el-table {
    margin-top: 3vh;
    margin-bottom: 3vh;
}

#OrderPrice {
    margin-bottom: 10vh;


}

strong {
    color: red;
}

ul {
    list-style-type: none;
    padding: 0;
}

#OrderCard {

    .el-card {
        border-left: 10px solid rgb(0, 153, 204);

    }
}

h4 {
    margin: 10px 0;
}
</style>