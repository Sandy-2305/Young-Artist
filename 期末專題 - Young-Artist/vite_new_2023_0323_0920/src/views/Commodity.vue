<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import axios from 'axios'
import Navbar from "@/components/Navbar/Navbar.vue";
import Commodity from "@/components/Commodity/Commodity.vue";
import Categorybar from "@/components/Categorybar/Categorybar.vue";
import { useCartStore } from '../stores/cart'
</script>

<template>
    <el-container>
        <el-main>
            <Navbar />
            <Commodity />
        </el-main>
    </el-container>
    <el-backtop :right="100" :bottom="100" />
</template>

<style lang="less" scoped>
@TestColor: rgb(209, 209, 209);
@NavbarColor: rgb(100, 192, 37);

.Product-title {
    font-size: 32px;
}

.el-container {
    width: 100%;
    height: 100%;

    .el-header {
        width: 100%;
        height: 100%;
        padding: 0;
        background-color: @TestColor;
    }

    .el-main {
        padding: 0;
        height: 100%;
        width: 100%;
    }
}
</style>