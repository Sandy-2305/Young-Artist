<script setup lang="ts">
import Chatbot from '@/components/Service/Chatbot.vue'
import Navbar from '@/components/Navbar/Navbar.vue'
import Footer from '@/components/Footer/Footer.vue';
</script>

<template>
    <el-container>
        <el-header>
            <!-- Header content -->
            <Navbar />
        </el-header>
        <el-main>
            <!-- Main content -->
            <Chatbot />
        </el-main>
        <el-footer>
            <!-- Footer content -->
            <Footer />
        </el-footer>
    </el-container>
</template>

<style scoped lang="less"></style>