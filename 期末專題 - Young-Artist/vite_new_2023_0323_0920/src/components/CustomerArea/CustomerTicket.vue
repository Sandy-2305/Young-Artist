<script setup lang="ts">
import { reactive, ref, computed, onMounted, toRaw } from 'vue';
import axios from 'axios';
import router from '@/router';
import { includes } from 'lodash';
import { CustomerStore } from '@/stores/CustomerStore';
import type { dataType, dataType_detail } from '@/types/TicketOrderInterface'
import type { PaymentInterface } from '@/types/PaymentInterface';
import CustomerMenu from './CustomerMenu.vue';
import { ElMessage } from 'element-plus'
//========================獲取會員資料=========================================
const customerData = CustomerStore().customerData
//=============================請求=====================================
// 請求網址
const url = ref("https://localhost:44393/api");
// 請求控制器
const action = ref("TicketOrders")

// 請求得到的訂單明細資料放的陣列
const data = reactive<dataType[]>([]);
// 請求得到的詳細訂單資料放的陣列
const data_detail = reactive<dataType_detail[]>([]);
//=============================請求=====================================

//=============================控制頁面=====================================

// 控制頁面顯示 v-if 訂單明細資料
const orderPage = ref(false)
// 控制頁面顯示 v-if 詳細訂單資料
const orderDetailPage = ref(false)

// 控制頁面顯示 v-if 詳細訂單資料上的標題
const TitleOrderId = ref(2);
const TitleName = ref("");
const TitleEventTime = ref("")

// 控制頁面隱藏所有訂單的詳細
const closeAllDetails = () => {
    for (let i = 0; i < data.length; i++) {
        data[i].detail = false;
    }
}
//=============================控制頁面=====================================

//=============================查詢訂單=====================================
// 看訂單(需要登入代入帳號)
const seeOrder = async () => {
    await axios
        .get(`${url.value}/${action.value}/${customerData[0].customerId}`)
        .then(response => {
            if (response.data == "") {
                // 控制頁面顯示 v-if 查無資料
                orderPage.value = false;
            }
            else {
                response.data.forEach((item: dataType, index: number) => {
                    response.data[index] = { ...item, detail: false };

                });
                response.data.forEach((item: dataType, index: number) => {
                    response.data[index] = { ...item, pop: false };

                });
                data.splice(0, response.data.length, ...response.data.reverse())
                dataPage.splice(0, toRaw(data).length, ...toRaw(data))

                orderPage.value = true;
                orderDetailPage.value = false;

            }

        })
        .catch(error => {
            console.log(error)
        })
    for (let i = 0; i < data.length; i++) {
        if (data[i].orderState == 0) {
            data[i].orderStateString = "未繳費";
        } else if (data[i].orderState == 1) {
            data[i].orderStateString = "已繳費";
        } else if (data[i].orderState == 2) {
            data[i].orderStateString = "已取消";
        } else if (data[i].orderState == 3) {
            data[i].orderStateString = "活動已結束";
        }
    }

}

const seeOrderDetail = async (orderId: number) => {
    console.log(orderId);

    await axios
        .get(`${url.value}/${action.value}/detail/${orderId}`)
        .then(response => {
            data_detail.splice(0, data_detail.length, ...response.data)
            // 獲取活動名稱
            axios.get(`https://localhost:44393/api/Events/Id/${data_detail[0].eventId}`)
                .then(res => {
                    TitleName.value = res.data[0].eventName;
                    TitleEventTime.value = res.data[0].eventSellStartTimestamp;
                })
                .catch(err => console.log(err));
            TitleOrderId.value = data_detail[0].orderId
        })
        .catch(error => {
            console.log(error)
        })
}


//=============================彈窗=========================================
const popupOrderId = ref(0)

const showPopup = (orderId: number) => {
    console.log(orderId);
    popupOrderId.value = orderId
}
//=============================彈窗=========================================
//=============================取消訂單=====================================
const cancelTicketOrderDetail = async () => {
    await axios.post(`https://localhost:44393/api/TicketOrders/CancelTicketOrderDetail/${popupOrderId.value}`, { "OrderId": popupOrderId.value })
        .then(res => {
            console.log(res)
            seeOrder();
            btnSuccess();
        })
        .catch(err => console.log(err));
}
const btnSuccess = () => {
    ElMessage({
        message: '已成功取消訂單',
        type: 'success',
    })
}
//=============================取消訂單=====================================
//===========================付款===========================================

let returnOBJ: PaymentInterface;
const myForm: any = ref(null)

const goTO = () => {
    myForm.value.submit();
}

const goToPay = async (orderId: number, orderPrice: number) => {
    localStorage.setItem("paymentOrderId", `${orderId}`)
    await axios
        .get(`${url.value}/${action.value}/detail/${orderId}`)
        .then(response => {
            data_detail.splice(0, data_detail.length, ...response.data)
        })
        .catch(error => {
            console.log(error)
        })
    await axios.get(`https://localhost:44393/api/Events/Id/${data_detail[0].eventId}`)
        .then(res => {
            TitleName.value = res.data[0].eventName;
            TitleEventTime.value = res.data[0].eventSellStartTimestamp;
        })
        .catch(err => console.log(err));
    await axios.post("https://localhost:44393/api/TicketOrders/GetCheckValue", {
        OrderId: `${orderId}`,
        Amt: `${orderPrice}`,
        ItemDesc: `${TitleName.value}票券`,
        TradeDesc: `${TitleName.value}票券`,
        Email: `${customerData[0].customerEmail}`,
        eventId: `${data_detail[0].eventId}`
    })
        .then(res => {
            localStorage.removeItem("TitleName")
            returnOBJ = res.data
            paybool.value = true;
        })
        .catch(err => {
            console.log(err)
        })
    goTO();

}
const paybool = ref(false)
//===========================付款===========================================
//===========================分頁===========================================
// PageList 
const dataPage = reactive<dataType[]>([]);

let currentPage = ref(1)
let pageSize = ref(3)
let total = ref(0)

const displayedOrder = computed(() => {
    const start = (currentPage.value - 1) * pageSize.value;
    const end = start + pageSize.value;
    total.value = data.length;
    return data.slice(start, end);
});

const handlePageChange = (page: number) => {
    currentPage.value = page;
};
//===========================分頁===========================================



onMounted(async () => {
    seeOrder();
    orderPage.value = true
    document.body.className = 'scroll-bar'

})
</script>

<template>
    <CustomerMenu />
    <el-row id="page">
        <el-col :lg="2" :xs="0" :offset="0"></el-col>
        <el-col :lg="20" :xs="24" :sm="20" :offset="0">
            <h1 id="Title">活動票券訂單列表</h1>
            <p v-if="!orderPage">查無訂單</p>
            <form ref="myForm" v-if="paybool" action='https://payment-stage.ecpay.com.tw/Cashier/AioCheckOut/V5'
                method='post'>
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
            <el-col v-for="(item, index) in displayedOrder" :key="item" v-if="orderPage">
                <el-card>
                    <div style="padding: 3px">
                        <div>訂單編號 : {{ item.orderId }}</div>
                        <div>訂單總價 : {{ item.orderTotalPrice }}</div>
                        <div>訂單建立時間 : {{ item.orderCreateTimestamp }} </div>
                        <div>訂單狀態 : {{ item.orderStateString }} </div>
                        <div class="bottom" style="padding-top: 10px;">
                            <el-row>
                                <el-col :xs="12" :sm="14" :md="16" :lg="18">
                                    <el-button v-if="item.detail == false && item.orderState != 2" type="primary"
                                        @click="seeOrderDetail(item.orderId), closeAllDetails(), item.detail = true">詳細</el-button>
                                    <el-button v-if="item.detail == false && item.orderState == 0" type="primary"
                                        @click="goToPay(item.orderId, item.orderTotalPrice)">去繳費</el-button>
                                    <el-button v-if="item.detail == true" type="primary" @click="item.detail = false">
                                        收回
                                    </el-button>

                                </el-col>
                                <el-col :xs="7" :sm="4" :md="3" :lg="2"></el-col>
                                <el-col :xs="5" :sm="6" :md="5" :lg="3">
                                    <el-button v-if="item.detail == false && item.orderState == 0" type="danger"
                                        @click="showPopup(item.orderId), item.pop = true">取消訂單</el-button>
                                </el-col>
                            </el-row>
                            <teleport to="body">
                                <div class="overlay" v-if="item.pop" @click="item.pop = false"></div>
                                <div class="popup" :class="{ hidden: !item.pop }">
                                    <div id="closeIconBox">
                                        <el-button type="danger" id="closeIcon" @click="item.pop = false">x</el-button>
                                        <el-row>
                                            <el-col :xs="0" :lg="3">
                                            </el-col>
                                            <el-col :xs="24" :lg="18">
                                                <p style="text-align: center;">您確定要取消「訂單 {{ popupOrderId }}」嗎？</p>
                                            </el-col>
                                            <el-col :xs="0" :lg="3">
                                            </el-col>
                                        </el-row>
                                        <div id="popBtnBox">
                                            <el-button class="popBtn" type="primary"
                                                @click="item.pop = false, cancelTicketOrderDetail()">確定</el-button>
                                            <el-button class="popBtn" type="danger" @click="item.pop = false">關閉</el-button>
                                        </div>
                                    </div>
                                </div>
                            </teleport>
                            <h2 v-if="item.detail">活動名稱 : {{ TitleName }}</h2>
                            <h2 v-if="item.detail">活動時間 : {{ TitleEventTime }}</h2>
                            <el-col v-for="(item_detail, index) in data_detail" :key="item_detail" v-if="item.detail">
                                <el-card id="CardDetail">
                                    <div style="padding: 3px">
                                        <h4>票券 ({{ index + 1 }})</h4>
                                        <div>座位 : {{ item_detail.area }}-{{ item_detail.seatId }} </div>
                                    </div>
                                </el-card>
                            </el-col>
                        </div>
                    </div>
                </el-card>

            </el-col>
            <div id="PageList">
                <el-pagination v-model="currentPage" :page-size="pageSize" :total="total" background
                    layout="prev, pager, next" @current-change="handlePageChange" />
            </div>
        </el-col>
        <el-col :lg="2" :xs="0" :offset="0"></el-col>
    </el-row>
</template>

<style scoped lang="less">
.scroll-bar {
    overflow-y: auto;
}

.scroll-bar::-webkit-scrollbar {
    width: 5px;
    height: 8px;
    background-color: #aaa;
}

.scroll-bar::-webkit-scrollbar-thumb {
    border-radius: 3px;
    background: rgba(0, 0, 0, 0.25);
}


#Title {
    @media screen and (max-width : 768px) {
        text-align: center;
    }
}


#PageList {
    display: flex;
    justify-content: center;
}



.el-pagination {
    margin-top: 10px;
}

#minWindowCustomerArea {
    display: flex;
    list-style: none;
    justify-content: space-around;
    padding: 0;
    flex: 1;

    li {
        border: 1px solid rgb(66, 140, 203);
        width: 100%;
        border-radius: 10%;
        padding: 3px;
        background-color: white;

        div {
            text-align: center;

        }

        a {
            text-decoration: none;
            font-size: 16px;
            color: rgb(0, 0, 0);
        }

        .icon {
            color: rgb(66, 140, 203);
        }
    }

    li:hover {
        background-color: rgb(66, 140, 203);

        a {
            text-decoration: none;
            font-size: 16px;
            color: rgb(255, 255, 255);
        }

        .icon {
            color: rgb(255, 255, 255);
        }
    }
}

.el-card {
    width: 97%;
    border-left: 10px solid rgb(0, 153, 204);
}

#CardDetail {
    border-left: 10px solid rgb(0, 204, 119);
}

// 彈窗相關
.overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    opacity: 0.7;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 1;
}

.popup {
    position: fixed;
    top: 50%;
    left: 50%;
    width: 30vw;
    height: 30vh;
    transform: translate(-50%, -50%);
    background-color: #fff;
    z-index: 2;

    @media screen and (max-width:768px) {
        width: 80vw;
        height: 50vh;
    }
}

.popup.hidden {
    display: none;
}

#closeIconBox {
    position: relative;
    width: 100%;
    height: 100%;
}

#closeIcon {
    position: absolute;
    top: -6%;
    right: -2%;
}

#popBtnBox {
    position: absolute;
    top: 100%;
    display: flex;
    width: 100%;
}

.popBtn {
    width: 50%;
    margin: 0;
}
</style>