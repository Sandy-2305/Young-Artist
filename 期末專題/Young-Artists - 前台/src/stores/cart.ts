import { defineStore,createPinia } from 'pinia'
export const useCartStore = defineStore('cart', {
  state: () => ({
    items: []
  }),
  actions: {
    addItem(item) {
      this.items.push(item)
    },
    removeItem(item) {
      const index = this.items.indexOf(item)
      this.items.splice(index, 1)
    }
  },
})