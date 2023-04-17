<script setup lang="ts">
import { reactive, ref } from 'vue'
import type { FormInstance, FormRules } from 'element-plus'
// import type { customerInterface } from '@/types/customerInterface'
import { CustomerStore } from '@/stores/CustomerStore';
import axios from 'axios';
import { useRouter } from 'vue-router';
const formSize = ref('default')

const ruleFormRef = ref<FormInstance>()
const router = useRouter();

const ruleForm = reactive({
    customerEmail: '',
    customerPassword: '',
    RememberMe:false,
})

// const 跳轉 = () => {
//     router.push('/CustomerAreaView')
// }

const rules = reactive({

    customerEmail: [
        { required: true, type: 'email', message: '請輸入正確電子郵件', trigger: 'blur' },
    ],
    customerPassword: [
        { required: true, message: '請輸入密碼', trigger: 'blur' },
        { min: 6, max: 10, message: '請輸入6~10個字元', trigger: 'blur' },
        { pattern: '(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{6,10}', message: '必須包含英數字、特殊字元', trigger: 'blur' },
    ],

})


const submitForm = (formEl: FormInstance | undefined) => {
    if (!formEl) return
    formEl.validate((valid) => {
        if (valid) {
            console.log('submit!')
            LogInPost();


        } else {
            console.log('error submit!')
            return false
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
const url = ref("https://localhost:44393/api/Customers")
const LogInPost = () => {
    axios
        .post(`${url.value}`, {
            "customerEmail": ruleForm.customerEmail,
            "customerPassword": ruleForm.customerPassword
        })
        .then(result => {
            if (result.data != "帳號或密碼錯誤") {
                console.log(result.data);
                customerData.splice(0, result.data.length, result.data)
                let dataString = JSON.stringify(result.data)
                localStorage.setItem("customerData", dataString)
                router.push('/')
                alert("登入成功")

            } else {
                alert("帳號密碼有誤")
            }

        })
        .catch(error => {
            console.log("錯誤");

        })
}

const LogInGet = () => {
    axios
        .get(`${url.value}`)
        .then(result => {
            console.log(result.data);
            ruleForm.customerEmail = result.data[1].customerEmail
            ruleForm.customerPassword = result.data[1].customerPassword
        })
        .catch(error => {
            console.log(error);

        })
}

const RememberMe = () =>{}
</script>

<template>
    <el-row>
        <el-col :span=15>
            <div class="div">
                <el-form ref="ruleFormRef" :model="ruleForm" :rules="rules" label-width="120px" class="demo-ruleForm"
                    :size="formSize" status-icon>
                    <el-form-item prop="customerEmail" required>
                        <el-input placeholder="電子郵件" v-model="ruleForm.customerEmail" type="email" class="input" />
                    </el-form-item>
                    <el-form-item prop="customerPassword" required>
                        <el-input placeholder="密碼" v-model="ruleForm.customerPassword" class="input" type="password" />
                        <span id="pwdcheck"></span><br />
                    </el-form-item>
                    <el-form-item>
                        <el-link href="../components/ForgetPassword.vue" type="primary" target="_blank" >忘記密碼</el-link>
                    </el-form-item>
                    <!-- <el-form-item prop="RememberMe">
                        <el-checkbox label="記住帳號、密碼" name="RememberMe" />
                    </el-form-item> -->
                    <el-form-item>
                        <el-button type="primary" @click="submitForm(ruleFormRef)">
                            登入
                        </el-button>
                        <el-button type="primary" @click="LogInGet">
                            登入測試
                        </el-button>
                    </el-form-item>
                    
                </el-form>
            </div>
        </el-col>
    </el-row>
</template>
 



<style>
input {
    width: 100px;
}

.div {
    padding: 30px;
}
</style>