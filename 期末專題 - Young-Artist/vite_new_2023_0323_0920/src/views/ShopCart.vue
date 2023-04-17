<script setup lang="ts">
import Navbar from "@/components/Navbar/Navbar.vue";
import ShopCart from "@/components/Commodity/ShopCart.vue";

</script>

<template>
    <el-container>
        <el-main>
            <Navbar />
            <ShopCart />
        </el-main>
    </el-container>
    <el-backtop :right="100" :bottom="100" />
</template>

<style lang="less" scoped></style>