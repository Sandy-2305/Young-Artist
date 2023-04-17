<script setup lang="ts">
import { reactive, ref, computed, onMounted } from 'vue';
import axios from 'axios';
import router from '@/router';
import { includes } from 'lodash';
import { CustomerStore } from '@/stores/CustomerStore';
import type { dataType, dataType_detail } from '@/types/TicketOrderInterface'
import { da } from 'element-plus/es/locale';
import CustomerMenu from './CustomerMenu.vue';

const customerData = CustomerStore().customerData
const url = ref("https://localhost:7165/Images/");

const data = reactive<dataType[]>([]);


const formatState = (row: any) => {
    console.log(row.isState)
    return row.isState ? '已審核' : '未審核'
}
const getOrder = async () => {
    await axios
        .get(`https://localhost:44393/api/OrderForms/CustomerCommodity/${customerData[0].customerId}`)
        .then(response => {
            data.splice(0, response.data.length, ...response.data)


        })
        .catch(error => {
            console.log(error)
        })

}
onMounted(async () => {
    getOrder();
})

</script>

<template>
    <CustomerMenu />
    <div style="padding-left:100px;">
        <h1>周邊商品訂單列表</h1>
        <el-table :data="data" style="width: 100%;height: 100%;" empty-text="目前沒有任何資料">

            <el-table-column label="圖片" eader-align="center" align="center">
                <template #default="scope">
                    <img :src="url + scope.row.commodityImage" style=" width:150px; height:150px;" />
                </template>
            </el-table-column>
            <el-table-column prop="commodityName" label="名稱" eader-align="center" align="center" />
            <el-table-column prop="commodityPrice" label="價格" eader-align="center" align="center" />
            <el-table-column prop="quantityOrder" label="數量" eader-align="center" align="center" />
            <el-table-column prop="isState" label="訂單狀態" :formatter="formatState" eader-align="center" align="center" />
        </el-table>
    </div>
</template>

<style scoped lang="less">
.el-col-14 {
    width: 100%;

    .el-card {
        width: 100%;
        border-left: 10px solid rgb(0, 153, 204);
    }
}
</style>