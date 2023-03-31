<script setup lang="ts">
import { reactive, ref } from 'vue'
import axios from 'axios';
import type { FormInstance, FormRules } from 'element-plus'
// import type { customerInterface } from '@/types/customerInterface'
import { CustomerStore } from '@/stores/CustomerStore';
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
    // customerCreatTimestamp: '',
    // customerUpdateTimestamp: '',
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
            SignUpPost()
            console.log('submit!')
        } else {
            console.log('error submit!', fields)
        }
    })
}

const resetForm = (formEl: FormInstance | undefined) => {
    if (!formEl) return
    formEl.resetFields()
}


const options = Array.from({ length: 10000 }).map((_, idx) => ({
    value: `${idx + 1}`,
    label: `${idx + 1}`,
}))


// const customerData = reactive<customerInterface[]>([]);
const customerData=CustomerStore().customerData;
const url = ref("https://localhost:44393/api/Customers/SignUp")
const SignUpPost = () => {
    axios.post(`${url.value}`, {
        "customerName": ruleForm.customerName,
        "customerEmail": ruleForm.customerEmail,
        "customerPassword": ruleForm.customerPassword,
        "customerPhone": ruleForm.customerPhone,
        "customerRegion": ruleForm.customerRegion,
        "customerAddress": ruleForm.customerAddress,
        "customerBirthDate": ruleForm.customerBirthDate,
        "customerGender": ruleForm.customerGender,
        // "customerCreatTimestamp": ruleForm.customerCreatTimestamp,
        // "customerUpdateTimestamp": ruleForm.customerUpdateTimestamp,
    })
        .then(result => {
            console.log(result.data);
            if (result.data != "帳號已存在") {
                alert("註冊成功")
                router.push("/");
            } else {
                alert("帳號已存在，請重新填寫「信箱」或「手機號碼」")
            }

        })
        .catch(error => {
            console.log(typeof (ruleForm.customerBirthDate));

            console.log(error);
            console.log("錯誤");

        })
}

const SignUpGet = () => {
    axios
        .get("https://localhost:44393/api/Customers/2")
        .then(result => {
            console.log(result.data);
            ruleForm.customerName = result.data.customerName
            ruleForm.customerPassword = result.data.customerPassword
            ruleForm.customerRegion = result.data.customerRegion
            ruleForm.customerAddress = result.data.customerAddress
            ruleForm.customerBirthDate = result.data.customerBirthDate
            ruleForm.customerGender = result.data.customerGender
        })
        .catch(error => {
            console.log(error);
        })
}

</script>

<template>
    <div class="div">
        <el-form ref="ruleFormRef" :model="ruleForm" :rules="rules" label-width="120px" class="demo-ruleForm"
            :size="formSize" status-icon>
            <div class="div2">

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
                    <el-form-item prop="customerBirthDate" style="width: 380px">
                        <el-date-picker v-model="ruleForm.customerBirthDate" type="date" label="生日" placeholder="請選擇生日"
                            style="width: 380px" />
                    </el-form-item>
                </el-col>
            </el-form-item>
            <el-form-item label="" prop="customerGender" required>
                <el-select v-model="ruleForm.customerGender" placeholder="請選生理性別" style="width: 400px;">
                    <el-option label="男" value="男" />
                    <el-option label="女" value="女" />
                </el-select>
            </el-form-item>

            <el-form-item>
                <el-button type="primary" @click="submitForm(ruleFormRef)">
                    註冊會員
                </el-button>
                <el-button @click="resetForm(ruleFormRef)">重新填寫</el-button>
                <el-button type="" @click="SignUpGet(ruleFormRef)">
                    註冊測試
                </el-button>
            </el-form-item>
    </div>

        </el-form>
    </div>
</template>

<style scoped>
input {
    width: 100px;
}

.div2 {
    width: 500px;
    margin: 20px 0 0 -73px;
}
.el-form{
width: 500px;
display:block;

}
</style>
 


