<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue';
import axios from 'axios'
import { TicketOrderStore } from '@/stores/TicketOrderStore'
import router from '@/router';
import { onBeforeRouteLeave } from 'vue-router';
import { ElMessage } from 'element-plus'

onMounted(async () => {
    btnSuccess();
    const OrderId = localStorage.getItem("paymentOrderId");
    console.log(OrderId);
    await axios.get(`https://localhost:44393/api/TicketOrders/Payment/${OrderId}`).then(res => console.log(res)).catch(err => console.log(err))
})

onBeforeRouteLeave(() => {
    localStorage.removeItem("paymentOrderId")
})

const goToCustomerArea = () => {
    router.push('/CustomerTicketView/')
}
const btnSuccess = () => {
    ElMessage({
        message: '完成下單，可至會員中心查看票券訂單',
        type: 'success',
    })
}
</script>

<template>
    <el-row>
        <el-col :span="5" :xs="0" :offset="0"></el-col>
        <el-col :span="14" :xs="24" :offset="0">
            <!-- <el-card> -->
            <div id="imgBox">
                <img src="./images/PaymentLogo.png" alt="">
                <h1>付款完成，請至會員中心確認訂單狀況</h1>
                <el-button type="primary" @click="goToCustomerArea()">前往會員中心</el-button>
            </div>
            <!-- </el-card> -->
        </el-col>
        <el-col :span="14" :xs="0" :offset="0"></el-col>
    </el-row>
</template>

<style lang="less" scoped>
#imgBox {
    text-align: center;
}
</style>