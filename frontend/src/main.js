import { createApp } from 'vue'
import './style.css'
import App from './App.vue'
import { createRouter, createWebHistory } from 'vue-router'

import LoginView from './pages/LoginView.vue'
import UserView from './pages/UserView.vue'
import AdminView from './pages/AdminView.vue'

import Toaster from '@meforma/vue-toaster'

const router = createRouter({
    history: createWebHistory(),
    routes: [
        {
            path: '/',
            redirect: '/login'
        },
        {
            path: '/login',
            component: LoginView
        },
        {
            path: '/basic',
            name: 'básico',
            component: UserView,
            meta: { requiresAuth: true, roles: ['basic'] }
        },
        {
            path: '/admin',
            name: 'administrador',
            component: AdminView,
            meta: { requiresAuth: true, roles: ['admin'] }
        }
    ]
})

const app = createApp(App)

app.use(router)
app.use(Toaster, {
    position: 'top-right',
    duration: 3000
})


app.mount('#app')