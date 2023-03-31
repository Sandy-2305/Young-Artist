<script lang="ts" setup>
import { ref, reactive, onMounted } from "vue";
import axios from 'axios';
import { useRouter } from 'vue-router'
import { EventStore } from '@/stores/EventStore'
import { CustomerStore } from "@/stores/CustomerStore";
import type { customerInterface } from '@/types/CustomerInterface'
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
onMounted(async () => {
    if (localStorage.getItem("token") != null) {
        isLogin.value = false
        await CustomerStore().getCustomerData();
        name.value = CustomerStore().customerData[0].customerName;

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
        <!-- 左側空白 -->
        <el-col :span="2" :offset="0"></el-col>
        <!-- 中間內容 -->
        <el-col :span="20" :offset="0">
            <!-- 中間再切24等分 -->
            <el-row>
                <el-col :span="16" :offset="0">
                    <div id="navbar-middle-left">
                        <ul>
                            <li id="LOGO">
                                <RouterLink to="/">
                                <li>
                                    <img src="./images/boy-blue-svgrepo-com.svg">
                                    <img src="./images/聞意青年.png">
                                </li>
                                </RouterLink>
                            </li>
                            <li>
                                <a href="#myEvent" target="_self">精彩活動</a>
                            </li>
                            <li id="input-bar">                             
                                <div class="search">
                                <input class="search" type="text" placeholder="搜尋活動" v-model="userInput" @keyup.enter="getKeyWord()">
                                
                                </div>
                                <svg viewBox="0 0 1024 1024" xmlns="http://www.w3.org/2000/svg" data-v-029747aa="">
                                    <path fill="currentColor"
                                        d="m795.904 750.72 124.992 124.928a32 32 0 0 1-45.248 45.248L750.656 795.904a416 416 0 1 1 45.248-45.248zM480 832a352 352 0 1 0 0-704 352 352 0 0 0 0 704z">
                                    </path>
                                </svg> 
                            </li>
                        </ul>
                    </div>
                </el-col>
                <el-col :span="8" :offset="0">
                    <div id="navbar-middle-right">
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
                                            <el-dropdown-item v-if="isLogin">
                                                <RouterLink to="/CustomerView" class="el-dropdown-item">登入・註冊</RouterLink>
                                            </el-dropdown-item>
                                            <el-dropdown-item v-if="!isLogin">
                                                <RouterLink to="/CustomerAreaView" class="el-dropdown-item">會員專區
                                                </RouterLink>
                                            </el-dropdown-item>
                                            <el-dropdown-item divided v-if="!isLogin">
                                                <RouterLink to="/ChatbotView" class="el-dropdown-item">客服機器人
                                                </RouterLink>
                                            </el-dropdown-item>
                                            <el-dropdown-item divided v-if="!isLogin">
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
        <el-col :span="2" :offset="0"> </el-col>
    </el-row>
    </el-affix>
</template>



<style scoped lang="less">
@NavbarColor: #ffffff;

.fa-icons {
    margin-right: 10px;
}


.el-col {
    width: 100%;
    height: 100px;
    background: @NavbarColor;
    // border-left: solid 1px black;
    padding: 0;
    // position: fixed;


    #navbar-middle-right {
        width: 100%;
        height: 100px;
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

            // li:hover {
            //     background-color: rgb(137, 194, 217);
            // }
        }
    }

    #navbar-middle-left {
        width: 100%;
        height: 100px;
        display: flex;

        ul {
            margin-top: 20px;
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
                    color:#2e587d;
                    font: bold 20px/1.5 '微軟正黑體'
                }

                input {
                    height: 100%;
                    width: 100%;
                    padding: 0;
                    border: 0;
                }
            }

            // li:hover {
            //     background-color: rgb(137, 194, 217);
            // }

            #input-bar {
                input {
                    font-size: 16px;
                }
            }

            #input-bar:hover {
                background-color: @NavbarColor;

            }

            #LOGO {
                padding: 0;
                margin-right: 3%;
                //margin-top: 30px;
                //margin-bottom: 30px;
                padding-top: 30px;
                padding-bottom: 30px;
            }

            #LOGO:hover {
                padding: 0;
                background-color: @NavbarColor;
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
    color:#2e587d;
    font-size: 25px;
    margin-inline: 10px;
}



.el-dropdown-item {
    text-decoration: none;
}

.search{
    // border: 0;
    // font-family: 'PingFang-SC','Lucida Grande','Helvetica', 'Arial', '微軟正黑體修正', '微軟正黑體', sans-serif !important;
    // display: inline-block;
    // text-indent: 0;
    // letter-spacing: normal;
    // word-spacing: normal;
    // text-transform: none;
    // color: initial;
    // text-shadow: none;
    // text-rendering: auto;
    // margin: 0;
    // -webkit-appearance: none;
    font-size: 12px;
    line-height: 20px;
    box-sizing: border-box;
    width: 214px;
    height: 25px;
    padding: 0 35px 0 15px;
    border-radius: 20px;
    outline: none;
    background: rgb(206, 228, 248);
}
</style>