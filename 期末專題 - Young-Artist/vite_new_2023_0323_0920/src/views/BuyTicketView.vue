<script setup lang="ts">
import BuyTicket from '@/components/BuyTicket/BuyTicket.vue'
import Navbar from '@/components/Navbar/Navbar.vue';
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
            <BuyTicket />
        </el-main>
        <el-footer>
            <!-- Footer content -->
            <Footer />
        </el-footer>
    </el-container>
    <el-backtop :right="100" :bottom="100" />
</template>

<style scoped lang="less"></style>