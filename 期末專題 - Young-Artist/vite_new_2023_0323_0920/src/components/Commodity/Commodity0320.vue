<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import axios from 'axios'
import Navbar from "@/components/Navbar/Navbar.vue";
import Carousel from "@/components/Carousel/Carousel.vue";
import Categorybar from "@/components/Categorybar/Categorybar.vue";
import { useCartStore } from '@/stores/cart'
import { CustomerStore } from '@/stores/CustomerStore';
import { now } from 'lodash';
const cartStore = useCartStore()
const customerStore = CustomerStore()
const url = 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg'

//創建Pinia儲存拿資料
//cartStore.addItem({a:'123'})
//console.log(cartStore.items);


let Commodity = reactive({});
let EvaluationForm = reactive({});
let productTitle = ref('');
let productSummary = ref('');
let productPrice = ref(0);
let productCount = ref(0);
let scoreTemplate = ref(0);
let rate = ref(0);
//路由參數
const route = useRoute()
const CommodityId = route.params.CommodityId;
//會員資料
//const 會員資料 = localStorage.getItem("會員資料")
const num = ref(1)
// const handleChange = (value) => {
//   console.log(value)
// }

const addShopCart = (async () => {
    //console.log(123);

    if (await customerStore.getCustomerData()) {
        let iscart = true

        for (let i = 0; i < cartStore.items.length; i++) {

            if (cartStore.items[i].commodityId == parseInt(CommodityId)) {
                iscart = false
                cartStore.items[i].quantityOrder += productCount.value
                axios.put('https://localhost:44393/api/OrderForms/', cartStore.items[i]).then(response => {
                    console.log(response.data);
                }).catch(err => console.log(err)
                )
            }

        }

        if (iscart) {
            const orderData = {
                "numberId": customerStore.customerData[0].customerId,
                "commodityId": parseInt(CommodityId),
                "quantityOrder": productCount.value,
                "isState": false,
                "IsCart": false,
            }
            axios.post(`https://localhost:44393/api/OrderForms`, orderData).then(response => {
                console.log(12345678);

                console.log(response.data);
                axios.get(`https://localhost:44393/api/OrderForms/member/${CustomerStore().customerData[0].customerId}`).then(response => {
                    console.log(response.data);
                    cartStore.items = [];
                    response.data.forEach(e => {
                        cartStore.addItem(e)
                    });
                    //console.log("長度:" + cartStore.items.length);


                }).catch((err) => console.log(err)
                )
                //console.log(cartStore.items);
            }).catch((err) => console.log(err)
            )
            //將資料加入Pinia
        }
    }




})
onMounted(async () => {
    //查詢某筆資料
    console.log(parseInt(CommodityId));
    //商品資料
    await axios.get(`https://localhost:44393/api/Commodities/${CommodityId}`).then(response => {
        Commodity = response.data
        //console.log(Commodity);
        //console.log(productTitle.value);
        productTitle.value = Commodity.commodityName;
        productSummary.value = Commodity.commodityNarrative.replace(/\\\\n/g, "<br>");
        productPrice.value = Commodity.commodityPrice;
        //productCount = Commodity['name'].length;
    })
    //商品評價
    await axios.get(`https://localhost:44393/api/EvaluationForms/commodity/${CommodityId}`).then(response => {
        EvaluationForm = response.data
        //console.log(EvaluationForm);
        for (let i = 0; i < EvaluationForm.length; i++) {
            rate.value += EvaluationForm[i].rate
            console.log(EvaluationForm.rate)
        }
        scoreTemplate.value = EvaluationForm.length
        rate.value = rate.value / EvaluationForm.length
    })
    //查詢所有資料並計算筆數 做分頁用
    // await axios.get('https://localhost:44393/api/Commodities').then(response => {
    // console.log(response.data);
    // console.log(productTitle.value);
    // console.log(response.data.length);
    // productCount = response.data.length;
    // })
})
</script>

<template>
    <el-container>
        <el-main>
            <!-- <Navbar/> -->
            <el-row>
                <el-col :span="5">
                    <div class="grid-content ep-bg-purple">
                        <i class="fa-brands fa-instagram"></i>
                    </div>
                </el-col>


                <el-col :span="7" style="margin-top:50px">
                    <div class="grid-content ep-bg-purple-light">
                        <div class="demo-image">
                            <el-image style="width: 100%;" :src="url" />
                        </div>
                    </div>
                </el-col>
                <el-col :span="7" style="margin-top:50px">
                    <div class="grid-content ep-bg-purple" style="margin-left: 50px;">
                        <div class="Product-title" style="margin-bottom: 25px;">{{ productTitle }}</div>
                        <div class="Product-summary" style="margin-bottom: 25px;" v-html="productSummary"></div>
                        <el-rate v-model="rate" disabled show-score text-color="#ff9900"
                            :score-template="`${rate} 分 (${scoreTemplate})人`" style="margin-bottom: 20px;" />
                        <div class="price" style="margin-bottom: 25px;">$ {{ productPrice }} NT</div>
                        <div>
                            購買數量:
                            <el-input-number v-model="productCount" :min="1" :max="10" />
                        </div>
                        <div class="" style="margin-top: 20px;">
                            <el-button type="success" round @click="addShopCart"><i
                                    class="fa-solid fa-cart-shopping"></i>加入購物車</el-button>
                            <el-button type="success" round><i class="fa-solid fa-bag-shopping"></i>直接購買</el-button>
                        </div>
                    </div>
                </el-col>



                <el-col :span="5">
                    <div class="grid-content ep-bg-purple-light"></div>
                </el-col>
            </el-row>
        </el-main>


    </el-container>
</template>

<style lang="less" scoped>
@TestColor: rgb(209, 209, 209);
@NavbarColor: rgb(100, 192, 37);

.Product-title {
    font-size: 32px;
}

.el-container {
    width: 100%;
    height: 100%;

    .el-header {
        width: 100%;
        height: 100%;
        padding: 0;
        background-color: @TestColor;
    }

    .el-main {
        padding: 0;
        height: 100%;
        width: 100%;
    }
}
</style>