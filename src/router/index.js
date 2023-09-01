import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/HomeView.vue'
import RequestsView from '../views/RequestsView.vue'
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home
    },
    {
      path: '/requests',
      name: 'requests',
      component: RequestsView
    }
  ]
})

export default router
