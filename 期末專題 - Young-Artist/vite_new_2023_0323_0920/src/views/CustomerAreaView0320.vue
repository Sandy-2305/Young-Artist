<script lang="ts" setup>
import CustomerArea from '@/components/CustomerArea/CustomerArea.vue'
import Navbar from '@/components/Navbar/Navbar.vue'
</script>
<template>
    <el-container>
        <el-header style="padding-bottom:50px;background-color: white;">
            <!-- Header content -->
            <Navbar />
        </el-header>
        <el-row>
            <el-col :span="5" :offset="0"></el-col>
            <el-col :span="14" :offset="0">
                <el-aside>
                    <!-- Aside content -->
                    <CustomerArea />
                </el-aside>
                <el-main>
                    <!-- Main content -->

                </el-main>
            </el-col>
            <el-col :span="5" :offset="0"></el-col>
        </el-row>
        <el-footer>
            <!-- Footer content -->

        </el-footer>
    </el-container>
</template>
