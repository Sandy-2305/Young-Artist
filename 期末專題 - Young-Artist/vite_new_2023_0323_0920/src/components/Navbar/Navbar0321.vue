<script lang="ts" setup>
import { ref, reactive, onMounted } from "vue";
import axios from 'axios';
import { useRouter } from 'vue-router'
import { EventStore } from '@/stores/EventStore'
import { CustomerStore } from "@/stores/CustomerStore";
import type { customerInterface } from '@/types/CustomerInterface'
import { Search } from '@element-plus/icons-vue'
import { useCartStore } from '../../stores/cart'

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
    console.log(cartStore.items);
}

const checkout = () => {
    router.push({ name: 'ShopCart' })
}

//請求訂單
const reqOrder = () => {
    axios.get(`https://localhost:44393/api/OrderForms/member/${CustomerStore().customerData[0].customerId}`).then(response => {
        console.log(response.data);
        cartStore.items = [];

        response.data.forEach(e => {
            cartStore.addItem(e)
        });
    }).catch((err) => console.log(err)
    )
}
const toCommodity = (CommodityId: number) => {
    router.push({ name: 'Commodity', params: { CommodityId: CommodityId } })
}

onMounted(async () => {
    //console.log(cartStore.items);
    if (localStorage.getItem("token") != null) {
        isLogin.value = false
        await CustomerStore().getCustomerData();
        name.value = CustomerStore().customerData[0].customerName;
        reqOrder();
    }
})
const isLogin = ref(true)
const logOut = () => {
    localStorage.removeItem("token")
}

const name = ref("")
const welcome = ref("歡迎")

</script>

<template >
    <el-affix :offset="0">
        <el-row>
            <el-col :span="24" :offset="0">
                <el-row>
                    <!-- navbar-middle-left 開始 -->
                    <el-col :span="16" :offset="0">
                        <div id="navbar-middle-left">
                            <ul>
                                <!-- 導航列LOGO -->
                                <li id="logo">
                                    <RouterLink to="/"><!-- 回到首頁 -->
                                        <img src="./images/boy-blue-svgrepo-com.svg" style="width: 30px;">
                                        <img src="./images/聞意青年.png">
                                    </RouterLink>
                                </li>

                                <!-- 導航列文字開始 -->
                                <li>
                                    <RouterLink to="/">
                                        <h3>首頁</h3>
                                    </RouterLink>
                                </li>

                                <!-- 跳到活動卡片 -->
                                <li>
                                    <a href="#myEvent" target="_self" style="align-items: baseline;">
                                        <h3>活動</h3>
                                    </a>
                                    <!-- 點擊跳轉到Card.vue <h1 id="myEvent">精彩活動</h1> -->
                                </li>

                                <!-- 路由要改 -->
                                <!-- 跳到商品購買 -->
                                <li>
                                    <RouterLink to="/CommdityList">
                                        <h3>周邊商品</h3>
                                    </RouterLink>
                                </li>

                                <!-- 路由要改 -->
                                <li v-if="isLogin">
                                    <RouterLink to="/"> <!-- 已登入跳進訂單畫面 -->
                                        <h3>訂購查詢</h3>
                                    </RouterLink>
                                </li>

                                <li v-if="!isLogin">
                                    <RouterLink to="/CustomerAreaView"> <!-- 尚未登入跳進會員專區畫面 -->
                                        <h3>訂購查詢</h3>
                                    </RouterLink>
                                </li>
                            </ul>
                            <!-- 導航列文字結束 -->

                            <!-- 搜尋活動輸入 -->
                            <div class="demo-input-size">
                                <el-input v-model="userInput" class="w-50 m-2" placeholder="搜尋活動" :suffix-icon="Search"
                                    @keyup.enter="getKeyWord()" />
                            </div>
                        </div>
                    </el-col>
                    <!-- navbar-middle-left 結束 -->

                    <!-- navbar-middle-right 開始 -->
                    <el-col :span="8" :offset="0">
                        <div id="navbar-middle-right">
                            <ul>
                                <li>
                                    <!-- 購物彈跳視窗開始 -->
                                    <div class="flex flex-wrap items-center">
                                        <el-dropdown size="large">
                                            <span class="el-dropdown-link">
                                                <div>
                                                    <i class="fa-solid fa-cart-plus"></i>
                                                </div>
                                            </span>
                                            <template #dropdown>
                                                <el-dropdown-menu style="width: 500px;">
                                                    <div style="width: 100%;">
                                                        <span class="font" style="width: 150px;">名稱</span>
                                                        <span class="font"
                                                            style="width: 50px;padding-left: 52px;padding-right: 8px;">數量</span>
                                                        <span class="font" style="width: 50px;">單價</span>
                                                    </div>
                                                    <el-dropdown-item v-for="cart in cartStore.items"
                                                        @click="toCommodity(cart.commodityId)"
                                                        v-show="cartStore.items.length > 0">
                                                        <!-- <span>{{cart.commodityName}} 暫定圖片商品名稱</span> -->
                                                        <span style=" width: 200px;">{{ cart.commodityName }}</span>
                                                        <span style=" width: 50px;padding: auto;">{{ cart.quantityOrder
                                                        }}</span>
                                                        <span style="padding-right: 50px; width: 50px;">{{
                                                            cart.commodityPrice }}</span>
                                                        <span @click="removeItem(cart)"> <i
                                                                class="fa-solid fa-trash"></i></span>
                                                    </el-dropdown-item>
                                                    <el-dropdown-item
                                                        style="width: 600px; height: 100px;text-align: center;"
                                                        v-if="cartStore.items.length == 0">
                                                        <p style="text-align: center;width: 600px;"> 購物車沒有商品</p>
                                                    </el-dropdown-item>
                                                    <el-divider />
                                                    <el-button type="danger" style="width: 95%;margin-left: 13px;"
                                                        v-show="cartStore.items.length > 0" @click="checkout">結帳</el-button>

                                                    <!-- <el-dropdown-item>Action 1</el-dropdown-item> -->
                                                </el-dropdown-menu>
                                            </template>
                                        </el-dropdown>
                                    </div>
                                </li>
                                <!-- 購物彈跳視窗結束 -->
                                <li>
                                    <div>
                                        <a v-show="name">{{ welcome }}&nbsp;{{ name }}</a>
                                    </div>
                                    <el-dropdown>
                                        <div class="member-area">
                                            <h3>會員服務</h3>
                                            <span class="el-dropdown-link">
                                                <div>
                                                    <i class="fa-solid fa-user icon"></i>
                                                </div>
                                            </span>
                                        </div>
                                        <template #dropdown>
                                            <el-dropdown-menu>
                                                <el-dropdown-item v-if="isLogin">
                                                    <RouterLink to="/CustomerView" class="el-dropdown-item">登入・註冊
                                                    </RouterLink>
                                                </el-dropdown-item>
                                                <el-dropdown-item v-if="!isLogin">
                                                    <RouterLink to="/CustomerAreaView" class="el-dropdown-item">會員專區
                                                    </RouterLink>
                                                </el-dropdown-item>
                                                <el-dropdown-item divided v-if="!isLogin">
                                                    <RouterLink to="/ChatbotView" class="el-dropdown-item">客服
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
                                </li>
                            </ul>
                        </div>
                    </el-col>
                </el-row>
            </el-col>
        </el-row>

    </el-affix>
</template>



<style scoped lang="less">
@NavbarColor: #ffffff;

.font {
    font-size: 15px;
    display: inline-block;
    /*更改此處數值調整寬度*/
    text-align: center;
    /*更改此處調整對齊方式*/
    font-weight: bold;
}

#logo {
    margin-left: 25px;
}

ul li h3 {
    font-size: 14px;
    margin-right: 16px;
}

/* 螢幕寬度小於等於 768px 時字體縮小至 8px */
@media (max-width: 768px) {
    ul li h3 {
        font-size: 8px;
    }
}

/* 螢幕寬度小於等於 480px 時字體縮小至 6px */
@media (max-width: 480px) {
    ul li h3 {
        font-size: 6px;
    }
}


// .fa-solid fa-user icon {
//     margin-right: 10px;
//     height:15px;
// }

.member-area {
    display: flex;
    align-items: center;
}

.member-area h3 {
    margin-right: 5px;
}

.el-row {
    box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.3);
}

.el-row:before,
.el-row:after {
    box-shadow: none;
}

.el-col {
    max-width: 100%;
    background: @NavbarColor;
    padding: 0;
    align-items: baseline;
    //display: flex;

    #navbar-middle-right {
        width: 100%;
        height: 100%;
        display: flex;


        ul {
            margin: 0;
            padding: 0;
            display: flex;
            list-style-type: none;
            width: 100%;
            justify-content: flex-end;
            margin-left: auto;



            li {
                padding: 0 5%;
                display: flex;
                align-items: center;

                a {
                    text-decoration: none;
                    color: #2e587d;
                }
            }

            li:hover {
                opacity: 0.7;
            }



            i:hover {
                opacity: 0.7;
            }
        }
    }

    #navbar-middle-left {
        width: 100%;
        display: flex;
        align-items: center;

        ul {
            padding: 0;
            display: flex;
            list-style-type: none;
            width: 100%;

            li {
                padding: 0 3%;
                display: flex;
                align-items: center;
                text-decoration: none;
                white-space: nowrap; //文字不換行

                a {
                    text-decoration: none;
                    color: #2e587d;
                }

                img {
                    width: 50%;
                }
            }

            li:hover {
                opacity: 0.7;
            }
        }
    }
}



// 下拉式選單
.example-showcase .el-dropdown-link {
    // cursor: pointer;
    // color: var(--el-color-primary);
    display: flex;
    align-items: end;

}

.icon {
    color: #2e587d;
    // font-size: 25px;
    // margin-inline: 10px;
}



.el-dropdown-item {
    text-decoration: none;
}
</style>