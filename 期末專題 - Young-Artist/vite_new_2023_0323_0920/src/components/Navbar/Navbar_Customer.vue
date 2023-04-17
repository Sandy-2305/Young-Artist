<script lang="ts" setup>
import {ref,onMounted} from "vue";
onMounted(()=>{
    if (localStorage.getItem("token")!=null) {
        isLogin.value = false
    }
})
const isLogin = ref(true)
const logOut = ()=>{
    localStorage.removeItem("token")
}

</script>

<template>
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
                                    <RouterLink to="/BuyTicketView/3"><i class="fa-solid fa-icons"></i>聞意青年</RouterLink>
                                </h1>
                            </li>
                            <li><a href="#">探索活動</a></li>
                            <li id="input-bar">
                                <svg viewBox="0 0 1024 1024" xmlns="http://www.w3.org/2000/svg" data-v-029747aa="">
                                    <path fill="currentColor"
                                        d="m795.904 750.72 124.992 124.928a32 32 0 0 1-45.248 45.248L750.656 795.904a416 416 0 1 1 45.248-45.248zM480 832a352 352 0 1 0 0-704 352 352 0 0 0 0 704z">
                                    </path>
                                </svg>
                                <input type="text" placeholder="搜尋活動">
                            </li>
                        </ul>
                    </div>
                </el-col>
                <el-col :span="8" :offset="0">
                    <div id="navbar-middle-right">
                        <ul>
                            <li>
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
                                            <el-dropdown-item divided v-if="!isLogin">
                                                <RouterLink to="/CustomerAreaView" class="el-dropdown-item">會員專區
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
    background: @NavbarColor;
    // border-left: solid 1px black;
    padding: 0;

    #navbar-middle-right {
        width: 100%;
        height: 40px;
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
        height: 40px;
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
}



.el-dropdown-item {
    text-decoration: none;
}
</style>