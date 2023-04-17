import { reactive } from 'vue'
import { defineStore } from 'pinia'
import type { customerInterface } from '@/types/CustomerInterface'
import axios from 'axios'
import router from '@/router'
export const CustomerStore = defineStore('CustomerStore', {
  state: () => {
    const customerData = reactive<customerInterface[]>([])

    const getCustomerData = async () => {
      let varify = false
      await axios.get("https://localhost:44393/api/Customers/verify", {
        headers: {
          'Authorization': 'Bearer ' + localStorage.getItem('token')
        }
      })
        .then(res => {
          if (!res.data) {
            localStorage.removeItem("token");
            alert("請重新登入")
            router.push("/CustomerView")
            varify = false
          } else {
            // console.log(res.data);
            const data = [res.data]
            customerData.splice(0, data.length, ...data)
            varify = true
          }
        })
        .catch(err => {
          console.log(err)
          varify = false
        });
      return varify
    }

    return { customerData, getCustomerData }
  },
})
