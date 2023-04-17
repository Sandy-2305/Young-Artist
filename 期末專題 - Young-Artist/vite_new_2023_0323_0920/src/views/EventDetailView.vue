<script setup lang="ts">
import EventDetail from '@/components/Event/EventDetail.vue'
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
            <EventDetail />
        </el-main>
        <el-footer>
            <!-- Footer content -->
            <Footer/>
        </el-footer>
    </el-container>
    <el-backtop :right="100" :bottom="100" />
</template>

<style scoped lang="less"></style>