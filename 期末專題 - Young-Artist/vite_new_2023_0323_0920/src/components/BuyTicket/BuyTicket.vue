<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import BuyTicket_Context from './BuyTicket_Context.vue';
import axios from 'axios';
import type { seatInterface } from '@/types/SeatInterface'
import type { eventInterface } from '@/types/EventInterface'
import type { customerInterface } from '@/types/CustomerInterface'
import { useRoute } from 'vue-router'
import { CustomerStore } from '@/stores/CustomerStore';
import { EventStore } from '@/stores/EventStore';
import router from '@/router';

const customerData = CustomerStore().customerData
////
// 要改用發請求的方式獲取資料
const eventData = EventStore().cardData
const seatData = reactive<seatInterface[]>([])
// 定義要傳回去的資料
const route = useRoute()
const eventId = ref(route.params.eventId)
// const eventId = ref(1)
const imgUrl = ref(``)

onMounted(async () => {
    await CustomerStore().getCustomerData();

    await axios
        .get(`https://localhost:44393/api/Events/Id/${eventId.value}`)
        .then(response => {
            console.log(response.data);
            eventData.splice(0, response.data.length, ...response.data)
            console.log(eventData[0].eventImage);
            imgUrl.value = "https://localhost:7165/Images/" + eventData[0].eventImage
        }).catch(err => console.log("錯誤"))

    await axios
        .get(`https://localhost:44393/api/SeatStocks/EventId/${eventId.value}`)
        .then(response => {
            console.log(response.data);
            // 添加count屬性
            response.data.forEach((item: seatInterface, index: number) => {
                response.data[index] = { ...item, count: 0 };
            });
            seatData.splice(0, response.data.length, ...response.data)
        }).catch(err => console.log("錯誤"))


})


</script>

<template>
    <el-row id="imageBox">
        <el-col  :xs="0" :sm="2" :md="4" :lg="6"></el-col>
        <el-col  :xs="24" :sm="20" :md="16" :lg="12">
            <img :src="imgUrl" alt="">
        </el-col>
        <el-col  :xs="0" :sm="2" :md="4" :lg="6"></el-col>
    </el-row>
    <el-row id="contextBox">
        <el-col  hidden-xs-only :sm="2" :md="4" :lg="6"></el-col>
        <el-col  :xs="24" :sm="20" :md="16" :lg="12">
            <BuyTicket_Context :customerData="customerData" :eventData="eventData" :seatData="seatData" :eventId="eventId">
            </BuyTicket_Context>
        </el-col>
        <el-col  hidden-xs-only :sm="2" :md="4" :lg="6"></el-col>
    </el-row>
</template>

<style scoped lang="less">
@TestColor: rgb(209, 209, 209);
@TestColor2: rgb(185, 185, 185);

#imageBox {
    background-color: @TestColor;
    padding: 0.5% 0;
    border-bottom: 1px solid @TestColor2 ;
}

#contextBox {
    margin-top: 2vh;
}

img {
    object-fit: cover;
    width: 100%;
    height: 100%;
}
</style>