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
import { ElMessage } from 'element-plus'

//基於斷點的隱藏
import 'element-plus/theme-chalk/display.css'

//menu測試
const activeIndex = ref('1')
const handleSelect = (key: string, keyPath: string[]) => {
    console.log(key, keyPath)
};

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
    router.push({ name: 'ShopCart' })
}
const gotoCommodity = (CommodityId) => {

    router.push({ name: 'Commodity', params: { CommodityId: CommodityId } })
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
    checkWindowWidth();
    if (localStorage.getItem("token") != null) {
        isLogin.value = false
        await CustomerStore().getCustomerData();
        name.value = CustomerStore().customerData[0].customerName;
        reqOrder();
    }
})
const isLogin = ref(true)
const logOut = () => {
    logOutSuccess();
    localStorage.removeItem("token")
}
const logOutSuccess = () => {
    ElMessage({
        message: '已成功登出',
        type: 'success',
    })
}
const name = ref("")
const welcome = ref("歡迎")

//客服彈窗
const visible = ref(false)
const visible_small = ref(false)
// 客服視窗大小
const ChatSize = ref("35%");
// 視窗相關
const checkWindowWidth = () => {
    windowWidth.value = window.innerWidth
}
const windowWidth = ref(0)
window.addEventListener('resize', () => {
    console.log(windowWidth.value)
    windowWidth.value = window.innerWidth
    if (windowWidth.value < 1400) {
        ChatSize.value = "80%";
    }
    else if (windowWidth.value < 700) {
        ChatSize.value = "100%";
    }
})



// Navbar活動關鍵字搜尋
const router = useRouter()
const CardData = EventStore().cardData
let userInput = ref("")

const getKeyWord = (userInput: string) => {
    EventStore().keyword = userInput
    router.push("EventCardView")
    const get = axios.get(`https://localhost:44393/api/Events/KeyWord/${EventStore().keyword}`)
        .then(response => {
            console.log(response.data);
            CardData.splice(0, CardData.length, ...response.data)
        })
        .catch(error => {
            console.log(error);
        })
    window.scrollTo(0, 0)

}

</script>

<template >
    <el-affix :offset="0">
        <el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal" :ellipsis="false"
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
            <el-menu-item class="hidden-lg-and-up">
                <el-dropdown>
                    <i class="fa fa-bars"></i>
                    <el-icon style="margin-right: 0px; margin-top: 1px">
                        <setting />
                    </el-icon>
                    <template #dropdown>
                        <el-dropdown-menu>
                            <RouterLink to="/"><el-dropdown-item>首頁</el-dropdown-item></RouterLink>
                            <RouterLink to="/EventCardView"><el-dropdown-item>活動</el-dropdown-item></RouterLink>
                            <RouterLink to="/CommdityList"><el-dropdown-item>周邊商品</el-dropdown-item></RouterLink>
                            <RouterLink to="/CustomerTicketView"><el-dropdown-item>訂購查詢</el-dropdown-item></RouterLink>
                            <a href="#aboutMe" target="_self"
                                style="align-items: baseline;"><el-dropdown-item>關於我們</el-dropdown-item></a>
                            <RouterLink to="/ShopCart"><el-dropdown-item>購物車</el-dropdown-item></RouterLink>
                            <!-- <el-dropdown-item>會員專區</el-dropdown-item> -->
                            <RouterLink to="/CustomerView" class="el-dropdown-item">
                                <el-dropdown-item index="2-1" v-if="isLogin">
                                    登入・註冊
                                </el-dropdown-item>
                            </RouterLink>
                            <RouterLink to="/CustomerDataView" class="el-dropdown-item">
                                <el-dropdown-item index="2-3" v-if="!isLogin">
                                    會員專區
                                </el-dropdown-item>
                            </RouterLink>
                            <RouterLink to="/CustomerTicketView" class="el-dropdown-item">
                                <el-dropdown-item index="2-4" v-if="!isLogin">
                                    查看訂單
                                </el-dropdown-item>
                            </RouterLink>
                            <RouterLink to="/CustomerView" class="el-dropdown-item" @click="logOut">
                                <el-dropdown-item divided v-if="!isLogin">
                                    登出
                                </el-dropdown-item>
                            </RouterLink>

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
                <RouterLink to="/CustomerTicketView">
                    <i class="fa-solid fa-barcode"></i>
                    <h3>訂購查詢</h3>
                </RouterLink>
            </el-menu-item>

            <!-- 跳到關於我們 -->
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
                    <div style="display: flex;">
                        <!-- <span>{{cart.commodityName}} 暫定圖片商品名稱</span> -->
                        <span class="CartTitle" style="width: 190px;">名稱</span>
                        <span style="width: 60px;">數量</span>
                        <span style="width: 50px;">單價</span>
                    </div>
                </el-menu-item>
                <el-menu-item index="6-2" v-for="cart in cartStore.items" v-show="cartStore.items.length > 0">
                    <!-- <span>{{cart.commodityName}} 暫定圖片商品名稱</span> -->
                    <span style="width: 200px;" @click="gotoCommodity(cart.commodityId)">{{ cart.commodityName }}</span>
                    <span style="width: 50px;">{{ cart.quantityOrder }}</span>
                    <span style="width: 50px;">{{ cart.commodityPrice }}</span>
                    <span @click="removeItem(cart)"> <i class="fa-solid fa-trash"></i></span>
                </el-menu-item>
                <el-menu-item index="6-3" style="width: 600px; height: 100px;text-align: center;"
                    v-if="cartStore.items.length == 0">
                    <p style="text-align: center;width: 600px;"> 購物車沒有商品</p>
                </el-menu-item>
                <el-divider />
                <el-menu-item index="6-4">

                    <el-button type="danger" style="width: 95%;margin-left: 13px;" v-show="cartStore.items.length > 0"
                        @click="checkout">結帳</el-button>
                    <!-- <el-dropdown-item>Action 1</el-dropdown-item> -->
                </el-menu-item>


            </el-sub-menu>

            <!-- 購物彈跳視窗結束 -->

            <!-- 會員專區下拉選單     -->
            <el-sub-menu index="7" class="hidden-md-and-down">
                <template #title>
                    <i class="fa-solid fa-user"></i>
                    <h3>會員專區</h3><a v-if="!isLogin" v-show="name" style="margin-left: 5px;">Hi!{{ name }}</a>
                </template>
                <RouterLink to="/CustomerView" class="el-dropdown-item">
                    <el-menu-item index="7-1" v-if="isLogin" style="width: 100%; display: flex; justify-content: center;">
                        登入・註冊
                    </el-menu-item>
                </RouterLink>
                <RouterLink to="/CustomerDataView" class="el-dropdown-item">
                    <el-menu-item index="7-2" v-if="!isLogin" style="width: 100%; display: flex; justify-content: center;">
                        會員資料
                        <!-- <el-divider /> -->
                    </el-menu-item>
                </RouterLink>
                <RouterLink to="/CustomerTicketView" class="el-dropdown-item">
                    <el-menu-item index="7-3" v-if="!isLogin" style="width: 100%; display: flex; justify-content: center;">
                        查看訂單
                    </el-menu-item>
                </RouterLink>
                <RouterLink to="/CustomerView" class="el-dropdown-item" @click="logOut">
                    <el-menu-item divided v-if="!isLogin" style="width: 100%; display: flex; justify-content: center;">
                        登出
                    </el-menu-item>
                </RouterLink>
            </el-sub-menu>

            <!-- 客服 -->
            <div class="service hidden-md-and-down">
                <li class="service" @click="visible = true" style="margin-left:10px;">
                    <i class="fa-brands fa-rocketchat"></i>
                    <h3>客服</h3>
                    <el-drawer v-model="visible" :show-close="false" :size='ChatSize'>
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
            </div>

            <!-- 搜尋活動輸入 -->
            <el-menu-item index="9">
                <div class="demo-input-size">
                    <el-input v-model="userInput" class="w-50 m-2" placeholder="搜尋活動" :suffix-icon="Search"
                        @keyup.enter="getKeyWord(userInput)" />
                </div>
            </el-menu-item>

            <div class="flex-grow" />
        </el-menu>
    </el-affix>
    <!-- 浮動客服 螢幕md時才出現-->
    <div id="chat-button" @click="visible_small = true" class="hidden-md-and-up">
        <img src="@/components/Navbar/images/chat_bot.jpg" style="width: 60px;box-shadow: 2px 4px 5px rgba(0, 0, 0, 0.7);">
    </div>
    <!-- 聊天框的內容 -->
    <el-drawer v-model="visible_small" :show-close="false" :size="windowWidth">
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
</template>



<style scoped lang="less">
@NavbarColor: #ffffff;



.CartTitle {}

#chat-button {
    position: fixed;
    bottom: 90px;
    right: 20px;
    cursor: pointer;
}

// #chat-box {
//   position: fixed;
//   bottom: 80px;
//   right: 100px;
//   width: 400px;
//   height: 400px;
//   background-color:white;
//   border: 1px solid black;
// }

.demo-input-size {
    display: flex;
    justify-content: center;
    align-items: center;
}

.service {
    font-size: 16px;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-left: auto;
    margin-right: 20px;
    //padding: 0px 0px;
}

.service:hover {
    color: #409eff;
    background-color: #ECF5FF;
    cursor: pointer;

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
    // font-weight: bold;
    margin-right: 20px;
}

h3:hover,
.el-sub-menu:hover {
    background-color: rgb(235, 241, 247);
}



h3,
strong,
a {
    font-size: 16px;
    //text-shadow: 0px 0px 2px rgba(0, 0, 0, 0.5);
}

.fa-solid {
    vertical-align: baseline !important;
}


/* 螢幕寬度小於等於 768px 時字體縮小至 14px */
@media (max-width: 768px) {

    h3,
    strong,
    a {
        font-size: 14px;
    }

}

/* 螢幕寬度小於等於 480px 時字體縮小至 12px */
@media (max-width: 480px) {

    h3,
    strong,
    a {
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