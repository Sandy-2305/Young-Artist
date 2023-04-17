<script lang="ts" setup>
import SingUp from '@/components/Customer/SignUp.vue'
import LogIn from '@/components/Customer/LogIn.vue'
import Navbar from '@/components/Navbar/Navbar.vue'
import Footer from '@/components/Footer/Footer.vue'
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
                    <div style="justify-content: center; display:flex;">
                        <el-tabs type="border-card" class="el-tabs">
                            <el-tab-pane label="登入">
                                <LogIn />
                            </el-tab-pane>
                            <el-tab-pane label="註冊">
                                <SingUp />
                            </el-tab-pane>
                        </el-tabs>
                    </div>
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
  

<style scoped lang="less">
.el-tabs {
    margin-top: 30px;
    background-color: #ffffff;
    width: 500px;
    height: 580px;
}


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