<script setup lang="ts">
import Navbar from "@/components/Navbar/Navbar.vue";
import Payment from "@/components/Payment/Payment.vue"
import Footer from '@/components/Footer/Footer.vue';
</script>

<template>
    <el-container>
        <el-header style="padding-bottom:67px;background-color: white;">
            <!-- Header content -->
            <Navbar />
        </el-header>
        <el-main>
            <!-- Main content -->
            <Payment />
        </el-main>
        <el-footer style="padding-top:11%;background-color: white;">
            <!-- Footer content -->
            <Footer />
        </el-footer>
    </el-container>
    <el-backtop :right="100" :bottom="100" />
</template>

<style lang="less" scoped></style>