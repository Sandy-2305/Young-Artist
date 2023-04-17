<script setup lang="ts">
import { reactive, ref, onMounted } from 'vue'
import { CustomerStore } from "@/stores/CustomerStore";
import CustomerMenu from './CustomerMenu.vue';
import { useRouter } from 'vue-router';
const router = useRouter()
const formSize = ref('default')
const ruleFormRef = ref()
const ruleForm = reactive({
    customerId: '',
    customerName: '',
    customerEmail: '',
    customerPassword: '',
    customerPhone: '',
    customerRegion: '',
    customerAddress: '',
    customerBirthDate: '',
    customerGender: '',
})





const options = Array.from({ length: 10000 }).map((_, idx) => ({
    value: `${idx + 1}`,
    label: `${idx + 1}`,
}))


const customerData = CustomerStore().customerData[0];
const url = ref("https://localhost:44393/api/Customers")
onMounted(() => {

    if (customerData != null) {

        console.log(customerData);
        ruleForm.customerId = customerData.customerId.toString()
        ruleForm.customerName = customerData.customerName
        ruleForm.customerEmail = customerData.customerEmail
        ruleForm.customerPassword = customerData.customerPassword
        ruleForm.customerPhone = customerData.customerPhone
        ruleForm.customerRegion = customerData.customerRegion
        ruleForm.customerAddress = customerData.customerAddress
        ruleForm.customerBirthDate = customerData.customerBirthDate
        if (customerData.customerGender == "M") {
            ruleForm.customerGender = "男"
        } else {
            ruleForm.customerGender = "女"
        }

    }
})



</script>

<template>
    <CustomerMenu />
    <el-main>
        <!-- Main content -->
        <div class="block">
            <h2 style="padding-left:120px;">我的會員資料</h2>
            <el-form ref="ruleFormRef" :model="ruleForm" label-width="120px" class="demo-ruleForm" :size="formSize"
                status-icon>
                <el-form-item label="" prop="customerId">
                    <el-input placeholder="" v-model="ruleForm.customerId" type="hidden" />
                </el-form-item>
                <el-form-item label="會員姓名：" prop="customerName">
                    <span>{{ ruleForm.customerName }}</span>
                </el-form-item>
                <el-form-item label="電子郵件：" prop="customerEmail">
                    <span>{{ ruleForm.customerEmail }}</span>
                </el-form-item>
                <el-form-item label="會員密碼：" prop="customerPassword">
                    <span>{{ ruleForm.customerPassword }}</span>
                </el-form-item>
                <el-form-item label="手機號碼：" prop="customerPhone">
                    <span>{{ ruleForm.customerPhone }}</span>
                </el-form-item>
                <el-form-item label="居住區域：" prop="customerRegion">
                    <span>{{ ruleForm.customerRegion }}</span>
                </el-form-item>
                <el-form-item label="詳細地址：" prop="customerAddress">
                    <span>{{ ruleForm.customerAddress }}</span>
                </el-form-item>
                <el-form-item label="生日日期：" prop="customerBirthDate">
                    <span>{{ ruleForm.customerBirthDate }}</span>
                </el-form-item>
                <el-form-item label="生理性別：" prop="customerGender">
                    <span>{{ ruleForm.customerGender }}</span>
                </el-form-item>
            </el-form>
        </div>
    </el-main>
</template>

<style scoped>
.block {
    margin-left: 100px;
}
</style>