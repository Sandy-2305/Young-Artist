import { ref } from 'vue'
import { reactive } from 'vue'
import { defineStore } from 'pinia'
import type { eventInterface } from '@/types/EventInterface'
export const EventStore = defineStore('EventStore', {
  state: () => {
    const cardData = reactive<eventInterface[]>([])
    let keyword = ref('')
    return { cardData , keyword}
  },
})
