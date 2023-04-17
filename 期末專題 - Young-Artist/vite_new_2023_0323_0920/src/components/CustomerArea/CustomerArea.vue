<script lang="ts" setup>
import router from '@/router';
import { Ticket, CollectionTag, Goods, EditPen, Right, ShoppingCart, Tickets } from '@element-plus/icons-vue'
import axios from 'axios';
// import url('https://fonts.googleapis.com/css2?family=Rubik+Gemstones&display=swap');
import { ref, reactive, onMounted } from 'vue'
import { CustomerStore } from '@/stores/CustomerStore';
import { ElMessage } from 'element-plus';


const customerData = CustomerStore().customerData

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
</script>

<template>
    <el-row>
        <el-col :span="5" :offset="0"></el-col>
        <el-col :span="14" :offset="0">
            <div>
                <el-container>
                    <!-- 側欄 -->
                    <!-- 會員姓名 -->
                    <el-aside width="200px" class="aside">
                        <el-row class="demo-basic">
                            <el-col :span="12">
                                <div class="sub-title">
                                    <div>
                                        <div class="block">
                                            <RouterLink to="/CustomerDataView">
                                                <i class="fa-solid fa-circle-user"></i>
                                            </RouterLink>
                                            <!-- <el-avatar :size="50" :src="circleUrl" /> -->
                                        </div>
                                    </div>
                                    <h2>{{ customerData[0]?.customerName }}</h2>
                                </div>
                            </el-col>
                        </el-row>
                        <!-- menu -->
                        <el-menu :default-openeds="['1', '3']" class="el-menu">
                            <el-sub-menu index="1">
                                <template #title>
                                    <el-icon>
                                        <Tickets class="icon" />
                                    </el-icon>
                                    <h3>所有訂單</h3>
                                </template>
                                <RouterLink to="/CustomerTicketView/" class="menu">
                                    <el-menu-item index="1-1">
                                        &emsp;<el-icon>
                                            <Ticket class="icon" />
                                        </el-icon>
                                        <h4>活動票券</h4>
                                    </el-menu-item>
                                </RouterLink>
                                <RouterLink to="/CustomerCommodity" class="menu">
                                    <el-menu-item index="1-2">
                                        &emsp;<el-icon>
                                            <Goods class="icon" />
                                        </el-icon>
                                        <h4>周邊商品</h4>
                                    </el-menu-item>
                                </RouterLink>
                            </el-sub-menu>

                            <RouterLink to="/CustomerShoppingcartView" class="menu">
                                <el-menu-item index="2">
                                    <template #title>
                                        <el-icon>
                                            <ShoppingCart class="icon" />
                                        </el-icon>
                                        <h3>商品評價</h3>
                                    </template>
                                </el-menu-item>
                            </RouterLink>

                            <RouterLink to="/CustomerFavoriteEventView" class="menu">
                                <el-menu-item index="3">
                                    <template #title>
                                        <el-icon>
                                            <CollectionTag class="icon" />
                                        </el-icon>
                                        <h3>收藏活動</h3>
                                    </template>
                                </el-menu-item>
                            </RouterLink>

                            <RouterLink to="/EditCustomerView" class="menu">
                                <el-menu-item index="4">
                                    <template #title>
                                        <el-icon>
                                            <EditPen class="icon" />
                                        </el-icon>
                                        <h3>修改會員資料</h3>
                                    </template>
                                </el-menu-item>
                            </RouterLink>

                            <RouterLink to="/CustomerView" class="menu" @click="logOut">
                                <el-menu-item index="5">
                                    <template #title>
                                        <el-icon>
                                            <Right class="icon" />
                                        </el-icon>
                                        <h3>登出</h3>
                                        <el-menu-item>
                                        </el-menu-item>
                                    </template>
                                </el-menu-item>
                            </RouterLink>

                        </el-menu>
                    </el-aside>
                </el-container>
            </div>
        </el-col>
        <el-col :span="5" :offset="0"></el-col>
    </el-row>
</template>



<style scoped>
/* 會員頭像、姓名 */
.fa-circle-user {
    color: #336699;
    font-size: 50px;
}

.demo-basic {
    text-align: center;
    justify-content: center;
    margin-bottom: 20px;
}

.demo-basic .sub-title {
    margin-bottom: 10px;
    font-size: 14px;
    color: var(--el-text-color-secondary);

}

.aside {
    border-right: 2px solid var(--el-border-color);
}


.demo-basic .demo-basic--circle,
.demo-basic .demo-basic--square {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.demo-basic .block {
    flex: 1;
}

.menu {
    text-decoration: none;
}

.icon {
    color: #336699;
}

h3,
h4 {
    color: #336699;
}

.el-menu {
    border: none !important;
}
</style>