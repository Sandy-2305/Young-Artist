<script setup lang="ts">
import Carousel from "@/components/Carousel/Carousel.vue";
import Categorybar from "@/components/Categorybar/Categorybar.vue";
import EventCard from "@/components/Event/EventCard.vue";
import Navbar from '@/components/Navbar/Navbar.vue';
import Footer from '@/components/Footer/Footer.vue';
import Announcement from '@/components/Announcement/Announcement.vue';
import { onMounted } from 'vue';

onMounted(() => {
    document.body.className = 'scroll-bar'
})

</script>

<template>
    <el-container>
        <el-header style="height:100%">
            <!-- Header content -->
            <Navbar />
        </el-header>
        <el-main>
            <!-- Main content -->
            <Carousel />
            <Categorybar />
            <Announcement />
            <EventCard />
        </el-main>
        <el-footer>
            <!-- Footer content -->
            <Footer />
        </el-footer>
    </el-container>
    <el-backtop :right="100" :bottom="100" />
</template>

<style scoped lang="less"></style>