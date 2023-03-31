<script setup lang="ts">
import { reactive, ref, onMounted } from 'vue'
import axios from 'axios';
import type { FormInstance, FormRules } from 'element-plus'
// import type { customerInterface } from '@/types/customerInterface'
import { CustomerStore } from '@/stores/CustomerStore'
import { useRouter } from 'vue-router';
import { el } from 'element-plus/es/locale';
import CustomerMenu from './CustomerMenu.vue';
import { rest } from 'lodash';

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

const rules = reactive({

    customerName: [
        { required: true, message: '請輸入姓名', trigger: 'blur' },
        { min: 2, max: 20, message: '姓名長度至少大於2個字', trigger: 'blur' },
    ],
    customerEmail: [
        { required: true, type: 'email', message: '請輸入正確電子郵件', trigger: 'blur' },
    ],
    customerPassword: [
        { required: true, message: '請輸入密碼', trigger: 'blur' },
        { min: 6, max: 10, message: '請輸入6~10個字元', trigger: 'blur' },
        { pattern: '(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{6,10}', message: '必須包含英數字、特殊字元', trigger: 'blur' },
    ],
    customerPhone: [
        { required: true, message: '請輸入手機號碼', trigger: 'blur' },
        { length: 12, message: '請輸入正確手機號碼', trigger: 'blur' },
        { pattern: /\d{4}-\d{3}-\d{3}/, message: '請輸入正確手機號碼', trigger: 'blur' },
    ],
    customerRegion: [
        {
            required: true,
            message: '請選擇居住區域',
            trigger: 'blur',
        },
    ],
    customerAddress: [
        {
            required: true,
            message: '請輸入地址',
            trigger: 'blur',
        },
    ],
    customerBirthDate: [
        {
            type: 'date',
            required: true,
            message: '請選擇生日',
            trigger: 'blur',
        },
    ],
    customerGender: [
        {
            required: true,
            message: '請選擇性別',
            trigger: 'blur',
        },
    ],

})

const submitForm = async (formEl: FormInstance | undefined) => {
    if (!formEl) return
    await formEl.validate((valid, fields) => {
        if (valid) {
            console.log('submit!')
        } else {
            console.log('error submit!', fields)
        }
    })
}

const options = Array.from({ length: 10000 }).map((_, idx) => ({
    value: `${idx + 1}`,
    label: `${idx + 1}`,
}))


//const user = JSON.parse(localStorage.getItem("customerData"))
// const customerData = reactive<customerInterface[]>([]);
const customerData = CustomerStore().customerData[0];
const url = ref("https://localhost:44393/api/Customers")
onMounted(() => {
    //localStorage.getItem("customerData")
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

const EditCustomer = () => {
    console.log(`${url.value}/${customerData.customerId}`);

    axios.put(`${url.value}/${customerData.customerId}`, {
        "customerName": ruleForm.customerName,
        "customerEmail": ruleForm.customerEmail,
        "customerPassword": ruleForm.customerPassword,
        "customerPhone": ruleForm.customerPhone,
        "customerRegion": ruleForm.customerRegion,
        "customerAddress": ruleForm.customerAddress,
        "customerBirthDate": ruleForm.customerBirthDate,
        "customerGender": ruleForm.customerGender,
        "customerUpdateTimestamp": customerData.customerUpdateTimestamp,
        "customerCreatTimestamp": customerData.customerCreatTimestamp,
        "customerId": customerData.customerId
    })
        .then(result => {
            console.log(result.data);
            if (result.data != "修改有誤") {

                // localStorage.removeItem("customerData")
                LogInPost()
                // CustomerStore().getCustomerData();

                // customerData.customerName = ruleForm.customerName
                // customerData.customerEmail = ruleForm.customerEmail
                // customerData.customerPassword = ruleForm.customerPassword
                // customerData.customerPhone = ruleForm.customerPhone
                // customerData.customerRegion = ruleForm.customerRegion
                // customerData.customerAddress = ruleForm.customerAddress
                // customerData.customerBirthDate = ruleForm.customerBirthDate
                // customerData.customerGender = ruleForm.customerGender
                //localStorage.setItem("customerData", JSON.stringify(customerData))
                //console.log(ruleForm);

                alert("修改成功")
                // router.push("/");
            } else {
                alert("修改有誤")
            }

        })
        .catch(error => {
            // console.log(typeof (ruleForm.customerBirthDate));

            console.log(error);
            console.log("錯誤2");

        })
}
const token = localStorage.getItem("token");
const Reseturl = ref("https://localhost:44393/api/Customers")
const LogInPost = () => {
    axios.get(`${Reseturl.value}/${customerData.customerId}`)
        .then(res => {
            CustomerStore().customerData[0] = res.data;
            console.log(res.data);
            ruleForm.customerName = res.data.customerName
            ruleForm.customerEmail = res.data.customerEmail
            ruleForm.customerPassword = res.data.customerPassword
            ruleForm.customerPhone = res.data.customerPhone
            ruleForm.customerRegion = res.data.customerRegion
            ruleForm.customerAddress = res.data.customerAddress
            ruleForm.customerBirthDate = res.data.customerBirthDate
            ruleForm.customerGender = res.data.customerGender
            axios
                .post(`${Reseturl.value}`, {
                    "customerEmail": res.data.customerEmail,
                    "customerPassword": res.data.customerPassword
                }, {
                    headers: {
                        'Authorization': 'Bearer ' + token
                    }
                })
                .then(result => {
                    if (result.data != "帳號或密碼錯誤") {
                        localStorage.setItem("token", result.data)
                    }

                })
                .catch(error => {
                    console.log("錯誤1");

                })
        }
        ).catch(err => {
            console.log(err);

        })

}
</script>

<template>
    <CustomerMenu />
    <el-main>
        <!-- Main content -->
        <div class="block">
            <h2 style="padding-left:120px;">修改會員資料</h2>
            <el-form ref="ruleFormRef" :model="ruleForm" :rules="rules" label-width="120px" class="demo-ruleForm"
                :size="formSize" status-icon>
                <el-form-item label="" prop="customerId">
                    <el-input placeholder="" v-model="ruleForm.customerId" type="hidden" />
                </el-form-item>
                <el-form-item label="" prop="customerName" required>
                    <el-input placeholder="姓名" v-model="ruleForm.customerName" type="text" />
                </el-form-item>
                <el-form-item label="" prop="customerEmail" required>
                    <el-input placeholder="電子郵件" v-model="ruleForm.customerEmail" type="email" />
                </el-form-item>
                <el-form-item label="" prop="customerPassword" required>
                    <el-input placeholder="密碼" v-model="ruleForm.customerPassword" />
                    <span id="pwdcheck"></span><br />
                    <p style="color:gray;font-size: 8px;">(6~10個字且必須包含英數字、特殊字元)</p>
                </el-form-item>
                <el-form-item label="" prop="customerPhone" required>
                    <el-input placeholder="手機號碼 09XX-XXX-XXX" v-model="ruleForm.customerPhone" />
                </el-form-item>
                <el-form-item label="" prop="customerRegion" required>
                    <el-select v-model="ruleForm.customerRegion" placeholder="請選擇居住區域" style="width: 380px">
                        <el-option label="基隆市" value="基隆市" />
                        <el-option label="台北市" value="台北市" />
                        <el-option label="新北市" value="新北市" />
                        <el-option label="桃園市" value="桃園市" />
                        <el-option label="新竹市" value="新竹市" />
                        <el-option label="新竹縣" value="新竹縣" />
                        <el-option label="苗栗縣" value="苗栗縣" />
                        <el-option label="彰化縣" value="彰化縣" />
                        <el-option label="南投縣" value="南投縣" />
                        <el-option label="雲林縣" value="雲林縣" />
                        <el-option label="嘉義市" value="嘉義市" />
                        <el-option label="嘉義縣" value="嘉義縣" />
                        <el-option label="台南市" value="台南市" />
                        <el-option label="高雄市" value="高雄市" />
                        <el-option label="屏東縣" value="屏東縣" />
                        <el-option label="台東縣" value="台東縣" />
                        <el-option label="花蓮縣" value="花蓮縣" />
                        <el-option label="宜蘭縣" value="宜蘭縣" />
                        <el-option label="澎湖縣" value="澎湖縣" />
                        <el-option label="金門縣" value="金門縣" />
                        <el-option label="連江縣" value="連江縣" />
                        <el-option label="其他" value="其他" />
                    </el-select>
                </el-form-item>
                <el-form-item label="" prop="customerAddress" required>
                    <el-input placeholder="詳細地址" v-model="ruleForm.customerAddress" type="text" />
                </el-form-item>
                <el-form-item label="" required>
                    <el-col :span="11">
                        <el-form-item prop="customerBirthDate">
                            <el-date-picker v-model="ruleForm.customerBirthDate" type="date" label="生日" placeholder="請選擇生日"
                                disabled style="width: 380px" />
                        </el-form-item>
                    </el-col>
                </el-form-item>
                <el-form-item label="" prop="customerGender" required>
                    <el-select v-model="ruleForm.customerGender" placeholder="請選生理性別" disabled style="width: 400px;">
                        <el-option label="男" value="男" />
                        <el-option label="女" value="女" />
                    </el-select>
                </el-form-item>

                <el-form-item>
                    <el-button type="primary" @click="EditCustomer(ruleFormRef)">
                        確認修改
                    </el-button>
                </el-form-item>
            </el-form>
        </div>
    </el-main>
</template>

<style scoped>
.block {
    width: 500px;
}
</style>