<script lang="ts" setup>
import CustomerArea from '@/components/CustomerArea/CustomerArea.vue'
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
            <el-row>
                <el-col :span="5" :offset="0"></el-col>
                <el-col :span="14" :offset="0">
                    <CustomerArea />
                </el-col>
                <el-col :span="5" :offset="0"></el-col>
            </el-row>
        </el-main>
        <el-footer>
            <!-- Footer content -->
            <Footer />
        </el-footer>
    </el-container>
    <el-backtop :right="100" :bottom="100" />
</template>

<style lang="less" scoped>
.el-header {
    @media screen and (max-width: 768px) {
        padding-bottom: 0px;

    }
}

.TopAndBottomPadding {
    padding-top: 67px;
    padding-bottom: 67px;

    @media screen and (max-width: 768px) {
        padding-top: 10;
        padding-bottom: 10px;
    }
}

.backgroundIMG {
    background-image: url(../components/BackgroundImages/demoBG.jpg);
    // backdrop-filter: blur(5px);

}
</style>
