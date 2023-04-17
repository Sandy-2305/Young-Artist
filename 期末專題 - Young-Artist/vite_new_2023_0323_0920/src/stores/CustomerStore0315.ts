import { reactive } from 'vue'
import { defineStore } from 'pinia'
import type { customerInterface } from '@/types/customerInterface'
export const CustomerStore = defineStore('CustomerStore', {
  state: () => {
    const customerData = reactive<customerInterface[]>([])
    return { customerData }
  },
})
