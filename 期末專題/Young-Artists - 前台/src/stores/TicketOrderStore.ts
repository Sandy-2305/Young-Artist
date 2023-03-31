import { reactive, ref } from 'vue'
import { defineStore } from 'pinia'
export const TicketOrderStore = defineStore('TicketOrderStore', {
  state: () => {
    const processStep = reactive({ process: 1 });
    const OrderId = ref(0);
    return { processStep,OrderId }
  },
})
