import { createApp } from 'vue'
import { createPinia } from 'pinia'

import App from './App.vue'
import router from './router'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import * as ElementPlusIconsVue from '@element-plus/icons-vue'
import axios from 'axios'
import VueAxios from 'vue-axios'
import './assets/main.css'
import '@fortawesome/fontawesome-free/css/all.css';



const app = createApp(App)
app.use(VueAxios, axios)
app.use(ElementPlus)
app.use(createPinia())
app.use(router)

app.mount('#app')
