<script lang="ts" setup>
import { Tickets, Ticket, GoodsFilled, CollectionTag, ShoppingCart, EditPen, Right } from '@element-plus/icons-vue'
import type { customerInterface } from '@/types/customerInterface'
import { ref, reactive, onMounted } from 'vue'
interface customerInterface {
    customerAddress: string,
    customerBirthDate: string,
    customerCreatTimestamp: string,
    customerEmail: string,
    customerGender: string,
    customerId: number,
    customerName: string,
    customerPassword: string,
    customerPhone: string,
    customerRegion: string,
    customerUpdateTimestamp: string,
    UserName: string,
}

// import url('https://fonts.googleapis.com/css2?family=Rubik+Gemstones&display=swap');


// const dataObject = ref()
// const customerData = reactive<customerInterface[]>([])
// onMounted(() => {
//     dataObject.value = localStorage.getItem("customerData")
//     const array = [(dataObject.value ? JSON.parse(dataObject.value) : null)]
//     customerData.splice(0, array.length, ...array)
//     console.log(customerData);
//     console.log(customerData[0].customerName);

// })

const name = ref("")

if (localStorage.getItem("customerData") != null) {
    const array = JSON.parse(localStorage.getItem("customerData"))
    console.log(array.CustomerName);
    name.value = array.CustomerName
}

const logOut = () => {
    localStorage.removeItem("customerData")
}

</script>

<template>
    <el-row>
        <el-col :span="5" :offset="0"></el-col>
        <el-col :span="14" :offset="0">
            <div class="common-layout">
                <el-container>
                    <!-- 側欄 -->
                    <!-- 會員姓名 -->
                    <el-aside width="200px">
                        <el-row class="demo-avatar demo-basic">
                            <el-col :span="12">
                                <div class="sub-title font">
                                    <div class="demo-basic--circle">
                                        <div class="block">
                                            <i class="fa-solid fa-circle-user"></i>
                                        </div>
                                    </div>
                                    {{ name }}
                                    <!-- {{ customerData[0]?.customerName }} -->
                                </div>
                            </el-col>
                        </el-row>

                        <!-- menu -->
                        <el-menu :default-openeds="['1', '3']">
                            <el-sub-menu index="1">
                                <template #title>
                                    <el-icon>
                                        <Tickets class="icon" />
                                    </el-icon>所有訂單
                                </template>
                                <RouterLink to="/CustomerTicketView" class="menu">
                                    <el-menu-item index="1-1">
                                        &nbsp;&nbsp;
                                        <el-icon><Ticket class="icon"/></el-icon>活動票券
                                    </el-menu-item>
                                </RouterLink>
                                <RouterLink to="/CustomerCommodity" class="menu">
                                    <el-menu-item index="1-2">
                                        &nbsp;&nbsp;
                                        <el-icon><GoodsFilled class="icon"/></el-icon>
                                        周邊商品
                                    </el-menu-item>
                                </RouterLink>
                            </el-sub-menu>

                            <RouterLink to="/CustomerShoppingcart" class="menu">
                                <el-menu-item index="2">
                                    <template #title>
                                        <el-icon>
                                            <ShoppingCart class="icon" />
                                        </el-icon>
                                        我的購物車
                                    </template>
                                </el-menu-item>
                            </RouterLink>

                            <RouterLink to="/CustomerFavoriteEvent" class="menu">
                                <el-menu-item index="3">
                                    <template #title>
                                        <el-icon>
                                            <CollectionTag class="icon" />
                                        </el-icon>收藏活動
                                    </template>
                                </el-menu-item>
                            </RouterLink>

                            <RouterLink to="/EditCustomerView" class="menu">
                                <el-menu-item index="4">
                                    <template #title>
                                        <el-icon>
                                            <EditPen class="icon" />
                                        </el-icon>修改會員資料
                                    </template>
                                </el-menu-item>
                            </RouterLink>

                            <RouterLink to="/CustomerView" class="menu" @click="logOut">
                            <el-menu-item index="5">
                                <template #title>
                                    <el-icon>
                                        <Right class="icon" />
                                    </el-icon>登出
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

.demo-basic .demo-basic--circle,
.demo-basic .demo-basic--square {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.demo-basic .block:not(:last-child) {
    border-right: 1px solid var(--el-border-color);
}

.demo-basic .block {
    flex: 1;
}

.demo-basic .el-col:not(:last-child) {
    border-right: 1px solid var(--el-border-color);
}

/* 側欄menu */
.layout-container-demo .el-header {
    position: relative;
    background-color: var(--el-color-primary-light-7);
    color: var(--el-text-color-primary);
}

.layout-container-demo .el-aside {
    color: var(--el-text-color-primary);
    background: var(--el-color-primary-light-8);
}

.layout-container-demo .el-menu {
    border-right: none;
}

.layout-container-demo .el-main {
    padding: 0;
}

.layout-container-demo .toolbar {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    height: 100%;
    right: 20px;
}

.menu {
    text-decoration: none;
}

.icon {
    color: #336699;
}
</style>