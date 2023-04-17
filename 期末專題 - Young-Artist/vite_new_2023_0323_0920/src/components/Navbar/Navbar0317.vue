<script lang="ts" setup>
import { ref, reactive, onMounted } from "vue";
import axios from 'axios';
import { useRouter } from 'vue-router'
import { EventStore } from '@/stores/EventStore'
import { CustomerStore } from "@/stores/CustomerStore";
import type { customerInterface } from '@/types/customerInterface'
import { useCartStore } from '../../stores/cart'
const router = useRouter()
const cardData = EventStore().cardData
let userInput = ref("")
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

        response.data.forEach(e => {
            cartStore.addItem(e)
        });
        //console.log("長度:" + cartStore.items.length);


    }).catch((err) => console.log(err)
    )
    //將資料加入Pinia
    console.log(cartStore.items);
}
//--購物車
const getKeyWord = async () => {
    await axios.get(`https://localhost:44393/api/Events/KeyWord/${userInput.value}
`)
        .then(response => {
            console.log(response.data);
            cardData.splice(0, cardData.length, ...response.data)
        })
        .catch(error => {
            console.log(error);
        })
}
onMounted(async () => {
    if (localStorage.getItem("token") != null) {
        isLogin.value = true
        await CustomerStore().getCustomerData();
        name.value = CustomerStore().customerData[0].customerName;
    }
    if (isLogin.value == true)
        reqOrder();
})
const isLogin = ref(false)
const logOut = () => {
    localStorage.removeItem("token")
}

const name = ref("")



const welcome = ref("歡迎")

</script>

<template >
    <el-row>
        <!-- 左側空白 -->
        <el-col :span="5" :offset="0"></el-col>
        <!-- 中間內容 -->
        <el-col :span="14" :offset="0">
            <!-- 中間再切24等分 -->
            <el-row>
                <el-col :span="16" :offset="0">
                    <div id="navbar-middle-left">
                        <ul>
                            <li id="LOGO">
                                <h1>
                                    <RouterLink to="/"><img src="./images/boy-blue-svgrepo-com.svg">&nbsp;&nbsp;聞意青年
                                    </RouterLink>
                                    <!-- <i class="fa-solid fa-icons"></i>-->
                                </h1>
                            </li>
                            <li>
                                <RouterLink to="/EventCardView">活動</RouterLink>
                            </li>
                            <li>
                                <RouterLink to="/CommdityList">商品</RouterLink>
                            </li>
                            <li id="input-bar">
                                <svg viewBox="0 0 1024 1024" xmlns="http://www.w3.org/2000/svg" data-v-029747aa="">
                                    <path fill="currentColor"
                                        d="m795.904 750.72 124.992 124.928a32 32 0 0 1-45.248 45.248L750.656 795.904a416 416 0 1 1 45.248-45.248zM480 832a352 352 0 1 0 0-704 352 352 0 0 0 0 704z">
                                    </path>
                                </svg>
                                <input type="text" placeholder="搜尋活動" v-model="userInput" @keyup.enter="getKeyWord()">
                            </li>
                        </ul>
                    </div>
                </el-col>
                <el-col :span="8" :offset="0">

                    <div id="navbar-middle-right">
                        <div class="flex flex-wrap items-center">
                            <el-dropdown>
                                <el-button type="primary">
                                    <i class="fa-solid fa-cart-shopping"></i>
                                </el-button>
                                <template #dropdown>

                                    <el-dropdown-menu>
                                        <div>
                                            <!-- <span>{{cart.commodityName}} 暫定圖片商品名稱</span> -->
                                            <span>名稱</span>
                                            <span>數量</span>
                                            <span>單價</span>
                                        </div>
                                        <el-dropdown-item v-for="cart in cartStore.items"
                                            v-show="cartStore.items.length > 0">
                                            <!-- <span>{{cart.commodityName}} 暫定圖片商品名稱</span> -->
                                            <span>{{ cart.commodityName }}</span>
                                            <span>{{ cart.quantityOrder }}</span>
                                            <span style="padding-right: 50px;">{{ cart.commodityPrice }}</span>
                                            <span @click="removeItem(cart)"> <i class="fa-solid fa-trash"></i></span>
                                        </el-dropdown-item>
                                        <el-dropdown-item style="width: 600px; height: 100px;text-align: center;"
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
                        <ul>
                            <li>
                                <div>
                                    <a v-show="name">{{ welcome }}&nbsp;{{ name }}</a>
                                </div>

                                <el-dropdown>
                                    <span class="el-dropdown-link">
                                        <div>
                                            <i class="fa-solid fa-user icon"></i>
                                        </div>
                                    </span>
                                    <template #dropdown>
                                        <el-dropdown-menu>
                                            <el-dropdown-item v-if="!isLogin">
                                                <RouterLink to="/CustomerView" class="el-dropdown-item">登入・註冊</RouterLink>
                                            </el-dropdown-item>
                                            <el-dropdown-item v-if="isLogin">
                                                <RouterLink to="/CustomerAreaView" class="el-dropdown-item">會員專區
                                                </RouterLink>
                                            </el-dropdown-item>
                                            <el-dropdown-item divided v-if="isLogin">
                                                <RouterLink to="/CustomerAreaView" class="el-dropdown-item">查看訂單
                                                </RouterLink>
                                            </el-dropdown-item>
                                            <el-dropdown-item divided v-if="isLogin">
                                                <RouterLink to="/CustomerView" class="el-dropdown-item" @click="logOut">登出
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
        <!-- 右側空白 -->
        <el-col :span="5" :offset="0"> </el-col>
    </el-row>
</template>




<style scoped lang="less">
@NavbarColor: #0099CC;

.fa-icons {
    margin-right: 10px;
}


.el-col {
    width: 100%;
    height: 60px;
    background: @NavbarColor;
    // border-left: solid 1px black;
    padding: 0;
    // position: fixed;


    #navbar-middle-right {
        width: 100%;
        height: 60px;
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
                    color: white;
                }
            }

            li:hover {
                background-color: rgb(137, 194, 217);
            }
        }
    }

    #navbar-middle-left {
        width: 100%;
        height: 60px;
        display: flex;

        ul {
            margin: 0;
            padding: 0;
            display: flex;
            list-style-type: none;
            width: 100%;

            li {
                padding: 0 3%;
                display: flex;
                align-items: center;

                svg {
                    width: 7%;
                    padding: 0 3%;
                    height: 100%;
                    background-color: white;
                }

                a {
                    text-decoration: none;
                    color: white;
                }

                input {
                    height: 100%;
                    width: 100%;
                    padding: 0;
                    border: 0;
                }
            }

            li:hover {
                background-color: rgb(137, 194, 217);
            }

            #input-bar {
                input {
                    font-size: 14px;
                }
            }

            #input-bar:hover {
                background-color: @NavbarColor;

            }

            #LOGO {
                padding: 0;
                margin-right: 3%;
            }

            #LOGO:hover {
                padding: 0;
                background-color: @NavbarColor;
            }
        }
    }
}

h1 {
    margin: 0;
    color: white;
}

// 下拉式選單
.example-showcase .el-dropdown-link {
    // cursor: pointer;
    // color: var(--el-color-primary);
    display: flex;
    align-items: end;

}

.icon {
    color: white;
    font-size: 25px;
    margin-inline: 10px;
}



.el-dropdown-item {
    text-decoration: none;
}
</style>