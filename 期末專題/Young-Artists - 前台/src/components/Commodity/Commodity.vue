<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import axios from 'axios'
import { useCartStore } from '@/stores/cart'
import { CustomerStore } from '@/stores/CustomerStore';
import { ElMessage } from 'element-plus'
import { useRouter } from 'vue-router'
const router = useRouter()


const cartStore = useCartStore()
const customerStore = CustomerStore()


//創建Pinia儲存拿資料
//cartStore.addItem({a:'123'})
//console.log(cartStore.items);


let Commodity = reactive({});
let EvaluationForm = reactive({});
let productTitle = ref('');
let productSummary = ref('');
let productImg = ref('https://localhost:7165/Images/');
let productPrice = ref(0);
let productCount = ref(0);
let scoreTemplate = ref(0);
let rate = ref(0);
let productNum = ref(0);
const mapContainer = ref(null);
const route = useRoute()
const CommodityId = route.params.CommodityId;
const num = ref(1)
const stock = ref("");

const addShopCart = (async () => {
    //console.log(123);
    ElMessage({
        message: '以添加商品至購物車',
        type: 'success',
    })
    if (await customerStore.getCustomerData()) {
        let iscart = true

        for (let i = 0; i < cartStore.items.length; i++) {

            if (cartStore.items[i].commodityId == parseInt(CommodityId)) {
                iscart = false

                cartStore.items[i].quantityOrder += productCount.value
                console.log(cartStore.items[i]);

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

const checkout = () => {
    addShopCart()
    router.push({ name: 'ShopCart' })
}


onMounted(async () => {

    //查詢某筆資料
    console.log(parseInt(CommodityId));
    //商品資料
    await axios.get(`https://localhost:44393/api/Commodities/${CommodityId}`).then(response => {
        Commodity = response.data
        //console.log(Commodity);
        //console.log(productTitle.value);
        productNum.value = Commodity.commodityNum;
        productImg.value += Commodity.commodityImage;
        productTitle.value = Commodity.commodityName;
        productSummary.value = Commodity.commodityNarrative.replace(/\\\\n/g, "<br>");
        productPrice.value = Commodity.commodityPrice;
        //productCount = Commodity['name'].length;
        if (Commodity.commodityNum > 20)
            stock.value = "庫存充足"
        else if (Commodity.commodityNum < 10 && Commodity.commodityNum > 0)
            stock.value = "庫存緊張"
        else if (Commodity.commodityNum === 0)
            stock.value = "銷售一空"
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

                </el-col>


                <el-col :span="7" style="margin-top:50px">
                    <div class="grid-content ep-bg-purple-light">
                        <div class="demo-image">
                            <el-image style="width: 100%;" :src="productImg" />
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
                            <span style="padding-left: 50px;color: red;">庫存量:{{ stock }}</span>
                        </div>
                        <div class="" style="margin-top: 20px;">
                            <el-button type="success" round @click="addShopCart" :disabled="productNum === 0"><i
                                    class="fa-solid fa-cart-shopping"></i>加入購物車</el-button>
                            <el-button type="success" round @click="checkout"><i
                                    class="fa-solid fa-bag-shopping"></i>直接購買</el-button>
                        </div>
                    </div>
                </el-col>



                <el-col :span="5">
                    <div class="grid-content ep-bg-purple-light"></div>
                </el-col>
            </el-row>
            <div class="mapContainer" ref="mapContainer"></div>
        </el-main>


    </el-container>
</template>

<style lang="less" scoped>
@TestColor: rgb(209, 209, 209);
@NavbarColor: rgb(100, 192, 37);


.mapContainer {
    height: 500px;
}

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