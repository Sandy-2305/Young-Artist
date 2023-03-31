<script setup lang="ts">
</script>

<template>
    <el-row>
        <!-- 左側空白 -->
        <el-col :span="6" :offset="0"></el-col>
        <!-- 中間內容 -->
        <el-col :span="12" :offset="0">
            <!-- 中間再切24等分 -->
            <el-row>
                <el-col :span="16" :offset="0">
                    <div id="navbar-middle-left">
                        <ul>
                            <li id="LOGO">
                                <h1>
                                    <RouterLink to="/BuyTicketView">KKTIX</RouterLink>
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
                                <RouterLink to="/CustomerView">註冊</RouterLink>
                            </li>
                            <li>
                                <RouterLink to="/CustomerView">登入</RouterLink>
                            </li>
                        </ul>
                    </div>
                </el-col>
            </el-row>
        </el-col>
        <!-- 右側空白 -->
        <el-col :span="6" :offset="0"> </el-col>
    </el-row>
</template>



<style scoped lang="less">
@NavbarColor: rgb(100, 192, 37);

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
                background-color: rgb(90, 166, 38);
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
                background-color: rgb(90, 166, 38);
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
}</style>