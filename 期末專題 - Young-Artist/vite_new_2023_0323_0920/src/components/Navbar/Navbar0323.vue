<script lang="ts" setup>
import { ref, reactive, onMounted } from "vue";
import axios from 'axios';
import { useRouter } from 'vue-router'
import { EventStore } from '@/stores/EventStore'
import { CustomerStore } from "@/stores/CustomerStore";
import type { customerInterface } from '@/types/CustomerInterface'
import { Search } from '@element-plus/icons-vue'
import { useCartStore } from '../../stores/cart'

import { ElButton, ElDrawer } from 'element-plus'
import { CloseBold } from '@element-plus/icons-vue'
import Chatbot from '@/components/Service/Chatbot.vue';
//基於斷點的隱藏
import 'element-plus/theme-chalk/display.css'

//menu測試
const activeIndex = ref('1')
const handleSelect = (key: string, keyPath: string[]) => {
    console.log(key, keyPath)
}

const router = useRouter()
const cardData = EventStore().cardData
let userInput = ref("")
const getKeyWord = async () => {
    await axios.get(`https://localhost:44393/api/Events/KeyWord/${userInput.value}
`)
        .then(response => {
            console.log(response.data);
            cardData.splice(0, cardData.length, ...response.data)
            router.push('/EventCardView')
        })
        .catch(error => {
            console.log(error);
        })
}

//購物車--
const cartStore = useCartStore()
const removeItem = (cart: any) => {
    axios.delete(`https://localhost:44393/api/OrderForms/${cart.id}`).then(response => {
        console.log(response.data);
        cartStore.removeItem(cart)
    })
    //console.log(cartStore.items);
}

const checkout = () => {

    const cart = JSON.stringify(cartStore.items)
    //console.log("未解碼:" + cart);
    const encoded = encodeURIComponent(cart);
    //console.log("解碼:" + encoded);

    axios.put(`https://localhost:44393/api/OrderForms/${encoded}`).then(response => {
        console.log(response.data);
    })
    cartStore.items = []
}

//請求訂單
const reqOrder = () => {
    axios.get(`https://localhost:44393/api/OrderForms/member/${CustomerStore().customerData[0].customerId}`).then(response => {
        console.log(response.data);
        //console.log(123);
        cartStore.items = [];

        response.data.forEach((e: any) => {
            cartStore.addItem(e)
        });
        //console.log("長度:" + cartStore.items.length);


    }).catch((err) => console.log(err)
    )
    //將資料加入Pinia
    console.log(cartStore.items);
}

onMounted(async () => {
    if (localStorage.getItem("token") != null) {
        isLogin.value = false
        await CustomerStore().getCustomerData();
        name.value = CustomerStore().customerData[0].customerName;
    }
    if (isLogin.value == true)
        reqOrder();
})
const isLogin = ref(true)
const logOut = () => {
    localStorage.removeItem("token")
}

const name = ref("")
const welcome = ref("歡迎")

//客服彈窗
const visible = ref(false)

</script>

<template >
    <el-affix :offset="0">
        <el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal" :ellipsis="true"
            @select="handleSelect" active-text-color="#2e587d">
            <el-menu-item index="0" id="logo">
                <!-- 導航列LOGO -->
                <RouterLink to="/"><!-- 回到首頁 -->
                    <img src="./images/boy-blue.png" style="width: 30px;">
                    <img src="./images/聞意青年.png" style="width: 80px;">
                </RouterLink>
            </el-menu-item>
            <div class="flex-grow" />

            <!-- 導航列漢堡圖示 -->
            <el-menu-item class="hidden-md-and-up">
            <i class="fa fa-bars"></i>
            <el-dropdown>
            <el-icon style="margin-right: 8px; margin-top: 1px"
              ><setting
            /></el-icon>
            <template #dropdown>
              <el-dropdown-menu>
                <RouterLink to="/"><el-dropdown-item>首頁</el-dropdown-item></RouterLink>
                <RouterLink to="/EventCardView"><el-dropdown-item>活動</el-dropdown-item></RouterLink>
                <RouterLink to="/CommdityList"><el-dropdown-item>周邊商品</el-dropdown-item></RouterLink>
                <RouterLink to="/CustomerAreaView"><el-dropdown-item>訂購查詢</el-dropdown-item></RouterLink>
                <a href="#aboutMe" target="_self" style="align-items: baseline;"><el-dropdown-item>關於我們</el-dropdown-item></a>
                <RouterLink to="/ShopCart"><el-dropdown-item>購物車</el-dropdown-item></RouterLink>
               <el-dropdown-item>會員專區</el-dropdown-item>

                <el-dropdown-item index="2-1" v-if="isLogin">
                    <RouterLink to="/CustomerView" class="el-dropdown-item">登入・註冊
                    </RouterLink>
                </el-dropdown-item>
                <el-dropdown-item index="2-3" v-if="!isLogin">
                    <!-- <el-divider /> -->
                    <RouterLink to="/CustomerDataView" class="el-dropdown-item">會員專區
                    </RouterLink>
                </el-dropdown-item>
                <el-dropdown-item index="2-4" v-if="!isLogin">
                    <RouterLink to="/CustomerTicketView" class="el-dropdown-item">查看訂單
                    </RouterLink>
                </el-dropdown-item>
                <el-dropdown-item divided v-if="!isLogin">
                    <RouterLink to="/CustomerView" class="el-dropdown-item" @click="logOut">
                        登出
                    </RouterLink>
                </el-dropdown-item>
                
              </el-dropdown-menu>
            </template>
          </el-dropdown>
            </el-menu-item>

            <!-- 導航列文字開始 -->
            <el-menu-item index="1" class="hidden-md-and-down">
            <RouterLink to="/">
                <i class="fa-solid fa-house-chimney"></i>
                    <h3>首頁</h3>
                </RouterLink>
            </el-menu-item>

            <!-- 跳到活動卡片 -->
            <el-menu-item index="2" class="hidden-md-and-down">
                <RouterLink to="/EventCardView">
                    <i class="fa-solid fa-calendar-days"></i>
                    <h3>活動</h3>
                </RouterLink>
            </el-menu-item>

            <!-- 跳到商品購買 -->
            <el-menu-item index="3" class="hidden-md-and-down">
                <RouterLink to="/CommdityList">
                    <i class="fa-brands fa-shopify"></i>
                    <h3>周邊商品</h3>
                </RouterLink>
            </el-menu-item>

            <!-- 跳到訂購查詢 -->
            <el-menu-item index="4" class="hidden-md-and-down">
                <RouterLink to="/CustomerAreaView">
                    <i class="fa-solid fa-barcode"></i>
                    <h3>訂購查詢</h3>
                </RouterLink>
            </el-menu-item>
            <el-menu-item index="5" class="hidden-md-and-down">
                <i class="fa-regular fa-face-grin-tongue-squint"></i>
                <a href="#aboutMe" target="_self" style="align-items: baseline;">
                    <!-- 點擊跳到Footer.vue <h3 class="title" id="aboutMe">關於我們</h3> -->
                    <h3>關於我們</h3>
                </a>
                </el-menu-item>
            <div class="flex-grow" />
            <!-- 導航列文字結束 -->

            <!-- 購物彈跳視窗開始 -->

            <el-sub-menu index="6" class="hidden-md-and-down">
                <template #title>
                    <i class="fa-solid fa-cart-plus"></i>
                    <strong>購物車</strong>
                </template>

                <el-menu-item index="6-1">
                <div>
                    <!-- <span>{{cart.commodityName}} 暫定圖片商品名稱</span> -->
                    <span style="width: 50px;">名稱</span>
                    <span style="width: 50px;">數量</span>
                    <span style="width: 50px;">單價</span>
                    </div>
                </el-menu-item>
                <el-menu-item index="6-2" v-for="cart in cartStore.items" v-show="cartStore.items.length > 0">
                    v-show="cartStore.items.length > 0">
                    <!-- <span>{{cart.commodityName}} 暫定圖片商品名稱</span> -->
                    <span>{{ cart.commodityName }}</span>
                    <span>{{ cart.quantityOrder }}</span>
                    <span style="padding-right: 50px;">{{ cart.commodityPrice }}</span>
                    <span @click="removeItem(cart)"> <i class="fa-solid fa-trash"></i></span>
                </el-menu-item>
                <el-menu-item index="6-3" style="width: 600px; height: 100px;text-align: center;"
                    v-if="cartStore.items.length == 0">
                    <p style="text-align: center;width: 600px;"> 購物車沒有商品</p>
                </el-menu-item>

                <el-menu-item index="6-4">
                    <el-divider />
                    <el-button type="danger" style="width: 95%;margin-left: 13px;" v-show="cartStore.items.length > 0"
                        @click="checkout">結帳</el-button>
                    <!-- <el-dropdown-item>Action 1</el-dropdown-item> -->
                </el-menu-item>


            </el-sub-menu>

            <!-- 購物彈跳視窗結束 -->

            <!-- 會員專區下拉選單     -->
            <el-sub-menu index="6" v-if="!isLogin" class="hidden-md-and-down">
                <template #title>
                    <a v-if="!isLogin" v-show="name">Hi!{{ name }}</a>
                    <i class="fa-solid fa-user"></i>
                    <h3>會員專區</h3>
                </template>
                <el-menu-item index="2-1" v-if="isLogin">
                    <RouterLink to="/CustomerView" class="el-dropdown-item">登入・註冊
                    </RouterLink>
                </el-menu-item>
                <el-menu-item index="2-3" v-if="!isLogin">
                    <!-- <el-divider /> -->
                    <RouterLink to="/CustomerDataView" class="el-dropdown-item">會員專區
                    </RouterLink>
                </el-menu-item>
                <el-menu-item index="2-4" v-if="!isLogin">
                    <RouterLink to="/CustomerTicketView" class="el-dropdown-item">查看訂單
                    </RouterLink>
                </el-menu-item>
                <el-menu-item divided v-if="!isLogin">
                    <RouterLink to="/CustomerView" class="el-dropdown-item" @click="logOut">
                        登出
                    </RouterLink>
                </el-menu-item>
            </el-sub-menu>

            <!-- 客服 -->

            <!-- <li class="Service" @click="visible = true"> -->
            <li class="service" @click="visible = true">
                <h3>
                    <i class="fa-brands fa-rocketchat"></i>
                    客服
                </h3>
                <el-drawer v-model="visible" :show-close="false">
                    <template #header="{ close, titleId, titleClass }">
                        <h1 :id="titleId" :class="titleClass">客服系統</h1>
                        <el-button circle @click="close">
                            <el-icon class="el-icon--center">
                                <CloseBold />
                            </el-icon>
                        </el-button>
                    </template>
                    <Chatbot />
                </el-drawer>
            </li>


            <!-- 搜尋活動輸入 -->
            <el-menu-item index="9">
                        <div class="demo-input-size">
                        <el-input v-model="userInput" class="w-50 m-2" placeholder="搜尋活動" :suffix-icon="Search"
                            @keyup.enter="getKeyWord()" />
                        </div>
                    </el-menu-item>

            <div class="flex-grow" />
        </el-menu>


    </el-affix>
</template>



<style scoped lang="less">
@NavbarColor: #ffffff;



.service,.demo-input-size {
    font-size: 16px;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-left: auto;
    margin-right: 20px;
    padding: 0px 20px;
    //color: #303133;
}

.service:hover {
    color: #409eff;
    background-color: #ECF5FF;
}

i {
    margin-right: 5px;
}

a {
    text-decoration: none;
    display: flex;
    justify-content: center;
    align-items: center;
}

span {
    font-weight: bold;
    margin-right: 20px;
}

#logo {
    margin-left: 25px;
    margin-right: 50px;
}

h3 {
    font-size: 16px;
    //text-shadow: 0px 0px 2px rgba(0, 0, 0, 0.5);
}

h3:hover,
.el-sub-menu:hover {
    background-color: rgb(235, 241, 247);
}



strong {
    font-size: 16px;
    //text-shadow: 0px 0px 2px rgba(0, 0, 0, 0.5);
}




/* 螢幕寬度小於等於 768px 時字體縮小至 14px */
@media (max-width: 768px) {
    h3 {
        font-size: 14px;
    }

    strong {
        font-size: 14px;
    }

}

/* 螢幕寬度小於等於 480px 時字體縮小至 12px */
@media (max-width: 480px) {
    h3 {
        font-size: 12px;
    }

    strong {
        font-size: 12px;
    }
}

.el-menu {
    box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.3);
    height: 60px;
    background-color: rgba(255, 255, 255, 0.5);
    //background-image: linear-gradient(to bottom, #ffffff, #f1f1f1);

}

.el-dropdown-item {
    text-decoration: none;
}
</style>