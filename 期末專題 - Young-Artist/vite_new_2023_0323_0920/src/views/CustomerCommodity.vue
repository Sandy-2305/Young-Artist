<script lang="ts" setup>
import CustomerArea from '@/components/CustomerArea/CustomerArea.vue'
import CustomerCommodity from '@/components/CustomerArea/CustomerCommodity.vue'
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
                <el-col hidden-sm-and-down :md="1" :lg="3" :xl="4" class="backgroundIMG"></el-col>
                <el-col :xs="24" :sm="24" :md="22" :lg="18" :xl="16" class="TopAndBottomPadding">
                    <el-row>
                        <el-col :xs="0" :sm="8" :md="7" :lg="5" :xl="5">
                            <CustomerArea />
                        </el-col>
                        <el-col :xs="24" :sm="16" :md="17" :lg="19" :xl="19">
                            <CustomerCommodity />
                        </el-col>
                    </el-row>
                </el-col>
                <el-col hidden-sm-and-down :md="1" :lg="3" :xl="4" class="backgroundIMG"></el-col>
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
        padding-top: 10px;
        padding-bottom: 10px;
    }
}

.backgroundIMG {
    background-image: url(../components/BackgroundImages/demoBG.jpg);
    // backdrop-filter: blur(5px);

}
</style>

