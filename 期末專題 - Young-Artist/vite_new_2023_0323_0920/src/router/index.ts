import { createRouter, createWebHistory } from 'vue-router'
import { CustomerStore } from '@/stores/CustomerStore';
import MainView from '../views/MainView.vue'
const varify = async (to: any, from: any, next: any) => {
  if (await CustomerStore().getCustomerData()) {
    next();
  } else {
    next('/CustomerView');
  }
}

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'MainView',
      component: MainView
    },
    {
      path: '/Navbar',
      name: 'Navbar',
      component: () => import('../components/Navbar/Navbar.vue')
    },
    {
      path: '/BuyTicketView/:eventId',
      name: 'BuyTicketView',
      component: () => import('../views/BuyTicketView.vue')
    },
    {
      path: '/CustomerView',
      name: 'CustomerView',
      component: () => import('../views/CustomerView.vue')
    },
    {
      path: '/CustomerAreaView',
      name: 'CustomerAreaView',
      component: () => import('../views/CustomerAreaView.vue'),
      beforeEnter: varify
    },
    {
      path: '/EditCustomerView',
      name: 'EditCustomerView',
      component: () => import('../views/EditCustomerView.vue'),
      beforeEnter: varify
    },
    {
      path: '/CustomerTicketView',
      name: 'CustomerTicketView',
      component: () => import('../views/CustomerTicketView.vue'),
      beforeEnter: varify
    },
    {
      path: '/EventCardView/',
      name: 'EventCardView',
      component: () => import('../views/EventCardView.vue')
    },
    {
      path: '/EventDetailView/:eventId',
      name: 'EventDetailView',
      component: () => import('../views/EventDetailView.vue')
    },
    {
      path: '/Announcement',
      name: 'Announcement',
      component: () => import('../components/Announcement/Announcement.vue')

    }
    ,
    {
      path: '/AnnouncementChange',
      name: 'AnnouncementChange',
      component: () => import('../components/AnnouncementChange/AnnouncementChange.vue')
    }
    ,
    {
      path: '/Detail/:detailsId',
      name: 'Detail',
      component: () => import('../components/AnnouncementDetail/Detail.vue')
    },
    {
      path: '/CommdityList',
      name: 'CommdityList',
      component: () => import('../views/CommodityList.vue')
    },
    {
      path: '/Commodity/:CommodityId',
      name: 'Commodity',
      component: () => import('../views/Commodity.vue')
    },
    {
      path: '/CustomerFavoriteEventView',
      name: 'CustomerFavoriteEventView',
      component: () => import('../views/CustomerFavoriteEventView.vue')
    },
    {
      path: '/ChatbotView',
      name: 'ChatbotView',
      component: () => import('../views/ChatbotView.vue')
    },
    {
      path: '/ShopCart',
      name: 'ShopCart',
      component: () => import('../views/ShopCart.vue'),
      beforeEnter: varify
    },
    {
      path: '/CustomerCommodity',
      name: 'CustomerCommodity',
      component: () => import('../views/CustomerCommodity.vue'),
      beforeEnter: varify
    },
    {
      path: '/PaymentView',
      name: 'PaymentView',
      component: () => import('../views/PaymentView.vue')
    },
    {
      path: '/CustomerDataView',
      name: 'CustomerDataView',
      component: () => import('../views/CustomerDataView.vue'),
      beforeEnter: varify
    },
    {
      path: '/CustomerShoppingcartView',
      name: 'CustomerShoppingcartView',
      component: () => import('../views/CustomerShoppingcartView.vue')
    }
  ]
})

export default router
