<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import axios from 'axios'
import { useCartStore } from '@/stores/cart'
import { CustomerStore } from '@/stores/CustomerStore';
import 'element-plus/theme-chalk/display.css'

const cartStore = useCartStore();
const customerStore = CustomerStore();
const url = ref('https://localhost:7165/Images/');
const CheckCount = reactive([]);
const myForm: any = ref(null)
const goTO = () => {
    myForm.value.submit();
}

let returnOBJ = {};
const goToPay = async () => {
    //購物車過濾
    const selectedItems = cartStore.items.filter(item => {
        return CheckCount.includes(item.commodityId);
    });


    let priceCount = 0
    let idCount = 0
    let quantityCount = 0
    let CommdityNameCount = ""
    selectedItems.forEach((item) => {
        CommdityNameCount += item.commodityName + "X" + item.quantityOrder + ","
        priceCount += item.commodityPrice
        idCount += item.id
        quantityCount += item.quantityOrder + ","

    })

    console.log(`${CommdityNameCount}`);
    console.log(selectedItems);
    CommdityNameCount = CommdityNameCount.slice(0, -1);
    console.log(`${CommdityNameCount}`);

    await axios.post("https://localhost:44393/api/OrderForms/GetCheckValue", {
        OrderId: "123",
        Amt: `${priceCount}`,
        //明細
        ItemDesc: `${CommdityNameCount}`,
        TradeDesc: `${quantityCount}`,
        Email: "1",
        eventId: 1
    })
        .then(res => {
            console.log(res.data)
            returnOBJ = res.data
            console.log(returnOBJ);
            isGoTo.value = true

        })
        .catch(err => {
            console.log(err)
        })
    await checkout()
    await goTO()

}


//選取到的商品ID丟進數組
const handleCheckboxChange = (isChecked: boolean, CommodityId: never) => {
    if (isChecked) {
        CheckCount.push(CommodityId)
    } else {
        let index = CheckCount.indexOf(CommodityId)
        if (index > -1) {
            CheckCount.splice(index, 1);
        }
    }

}
//移除訂單
const removeOrder = (cart: any) => {
    axios.delete(`https://localhost:44393/api/OrderForms/${cart.id}`).then(response => {
        console.log(response.data);
        cartStore.removeItem(cart)
    })
}
const checkout = () => {
    //過濾選取到的訂單
    const selectedItems = cartStore.items.filter(item => {
        return CheckCount.includes(item.commodityId);
    });
    //過濾沒選到的訂單
    const unselectedItems = cartStore.items.filter(item => {
        return !CheckCount.includes(item.commodityId);
    });
    console.log(unselectedItems);

    const unselectedItemsData = selectedItems.map(({ id, commodityId, isCart, numberId, orderTime, quantityOrder, isSatae }) => ({
        id,
        commodityId,
        isCart,
        numberId,
        orderTime,
        quantityOrder,
        isSatae
    }));
    console.log(unselectedItemsData);

    const encoded = encodeURIComponent(JSON.stringify(unselectedItemsData));
    console.log(encoded);

    axios.put(`https://localhost:44393/api/OrderForms/${encoded}`).then(response => {
        console.log(response.data);

        cartStore.items = unselectedItems;
    }).catch(err => console.log(err)
    )

}

onMounted(async () => {
    console.log(customerStore.customerData[0]);
    checkWindowWidth();
    await axios.get(`https://localhost:44393/api/OrderForms/member/${CustomerStore().customerData[0].customerId}`).then(response => {
        console.log(response.data);
        cartStore.items = [];
        response.data.forEach(e => {
            cartStore.addItem(e)
        });
    }).catch((err) => console.log(err)
    )
    //將資料加入Pinia
    console.log(cartStore.items);
})
const isGoTo = ref(false);

// 視窗相關
const checkWindowWidth = () => {
    windowWidth.value = window.innerWidth;
}
const windowWidth = ref(0);
window.addEventListener("resize", () => {
    windowWidth.value = window.innerWidth;
})
</script>

<template>
    <el-row style="padding-top: 50px;">
        <el-col :span="2"></el-col>
        <el-col :span="20">
            <el-table :data="cartStore.items" height="100%" style="width: 100%">
                <!-- v-if="windowWidth>768" -->
                <el-table-column label="選項" header-align="center" align="center">
                    <template #default="scope">
                        <el-checkbox v-model="scope.row.isChecked"
                            @change="handleCheckboxChange(scope.row.isChecked, scope.row.commodityId)">選取</el-checkbox>
                    </template>
                </el-table-column>
                <el-table-column label="圖片" eader-align="center" align="center" class="Image">
                    <template #default="scope">
                        <img :src="url + scope.row.commodityImage" style=" width:150px; height:150px;" />
                    </template>
                </el-table-column>
                <el-table-column prop="commodityName" label="名稱" eader-align="center" align="center" />
                <el-table-column prop="commodityPrice" label="價格" eader-align="center" align="center" />
                <el-table-column prop="quantityOrder" label="數量" eader-align="center" align="center" />
                <el-table-column prop="commodityNum" label="庫存量" v-if="windowWidth > 768" eader-align="center"
                    align="center" class="hidden-sm-only" />
                <el-table-column label="刪除">
                    <template #default="scope">
                        <el-button type="danger" @click="removeOrder(scope.row)"><i
                                class="fa-solid fa-trash"></i></el-button>
                    </template>
                </el-table-column>
            </el-table>
        </el-col>


        <el-col :span="2">

        </el-col>
    </el-row>
    <el-row>
        <el-col :span="8" :offset="12" style="padding-top: 50px;">
            <form v-if="isGoTo" ref="myForm" action='https://payment-stage.ecpay.com.tw/Cashier/AioCheckOut/V5'
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
            <el-button type="primary" style="width: 20%;float: right; margin-right: 10px;"
                @click="goToPay()">前往付款</el-button>
            <!-- <el-button type="primary" style="width: 20%;float: right; margin-right: 10px;" @click="checkout">結帳</el-button> -->
        </el-col>
    </el-row>
</template>
<style >
@media (max-width:1200px) {
    .image {
        display: none
    }
}
</style>