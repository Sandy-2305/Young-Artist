<!--聊天機器人-->
<script setup lang="ts">
import { reactive, ref, onMounted } from 'vue'

interface MessageWithActions {
  sender: string;
  text: string;
  actions: {
    type: string;
    label: string;
    url: string;
  }[];
}


const messages = reactive([
    // { sender: "bot", text: "" },

]);
const newMessage = ref("");
const ActivityOptions = ref(false);

const resetMessages = () => {
      newMessages.value = "";
    };

function sendMessage() {
    messages.push({ sender: "user", text: newMessage.value });
    if (
        newMessage.value.includes("bye") ||
        newMessage.value.includes("再見") ||
        newMessage.value.includes("掰掰") 
        ) {
        messages.push({ sender: "bot", text: "輸入中..." });
        setTimeout(function () {
                messages.pop();
                messages.push({ sender: "bot", text: "再見，期待能再為您服務。" });
            }, 1000);        
    } else if (
        newMessage.value.includes("你好") ||
        newMessage.value.includes("嗨") ||
        newMessage.value.includes("哈囉")
    ) {
        messages.push({ sender: "bot", text: "輸入中..." });
        setTimeout(function () {
                messages.pop();
                messages.push({sender: "bot", text: "您好，請選擇您需要的服務。",});
            }, 1000);
        
    }else if (newMessage.value.includes("時間") || newMessage.value.includes("幾點")) {
        messages.push({ sender: "bot", text: "輸入中..." });
        setTimeout(function () {
                messages.pop();
                messages.push({ sender: "bot", text: "現在時間是 " + new Date().toLocaleTimeString() + "。",});
            }, 1000);
        
    }else if (newMessage.value.toLowerCase() === "1"|| newMessage.value.includes("商品")) {
        messages.push({ sender: "bot", text: "輸入中..." });
        setTimeout(function () {
                messages.pop();
                messages.push({ sender: "bot", text:"您可至上方導航欄點選「周邊商品」開始選購您喜愛的商品。",});
            }, 1000);
        
    }else if (newMessage.value.toLowerCase() === "2"|| newMessage.value.includes("購物")) {
        messages.push({ sender: "bot", text: "輸入中..." });
        setTimeout(function () {
                messages.pop();
                messages.push({ sender: "bot", text:"您可至上方導航欄點選「購物車」或至「會員專區」查看您選購的商品。",});
            }, 1000);
        
    }else if (newMessage.value.toLowerCase() === "3"|| newMessage.value.includes("訂單")) {
        messages.push({ sender: "bot", text: "輸入中..." });
        setTimeout(function () {
                messages.pop();
                messages.push({ sender: "bot", text:"請您先註冊或登入會員，再至會員專區查看訂單。",});
            }, 1000);
    }
    else {
        messages.push({ sender: "bot", text: "輸入中..." });
        setTimeout(function () {
                messages.pop();
                messages.push({sender: "bot",text: "抱歉，無法處理您輸入的資訊，請選擇您需要的服務，或聯繫真人客服，謝謝。",});
            }, 1000);
    }
    newMessage.value = "";
}

function sendActivityInfo() {
    messages.push({ sender: "user", text: "我想查詢活動資訊" });
    messages.push({ sender: "bot", text: "輸入中..." });

    setTimeout(function () {
        messages.pop();
        messages.push({ sender: "bot", text: "請問您想查詢？" });

        // 設定 ActivityOptions 變數為 true，以顯示按鈕
        ActivityOptions.value = true;
    }, 1000);
}

function handleActivityOptionClick(event) {
    switch (event.target.innerText) {
        // 轉跳到查看所有活動的頁面
        case '查看所有活動':
            messages.push({ sender: "user", text: "我想查看所有活動" });
            ActivityOptions.value = false;
            messages.push({ sender: "bot", text: "輸入中..." });

            setTimeout(function () {
                messages.pop();
                messages.push({ sender: "bot", text: "您可按導航欄上的「活動」按鈕或至首頁查看所有活動。" });
            }, 1000);
            break;

        // 回覆活動最新消息的文字訊息
        case '活動最新消息':
            messages.push({ sender: "user", text: "我想了解活動最新消息。" });
            ActivityOptions.value = false;
            messages.push({ sender: "bot", text: "輸入中..." });

            setTimeout(function () {
                messages.pop();
                messages.push({ sender: "bot", text: "您可至首頁的公告或個別活動頁面查看活動最新消息。" });
            }, 1000);
            break;

        // 回覆活動詳細資訊的文字訊息
        case '活動詳細資訊':
            messages.push({ sender: "user", text: "我想了解活動詳細資訊。" });
            ActivityOptions.value = false;
            messages.push({ sender: "bot", text: "輸入中..." });

            setTimeout(function () {
                messages.pop();
                messages.push({ sender: "bot", text: "您可至個別活動頁面查看活動詳細資訊。" });
            }, 1000);
            break;

        default:
            break;
    }
}


function sendTicketInfo() {
    messages.push({ sender: "user", text: "我想查詢購票資訊。" });
    messages.push({ sender: "bot", text: "輸入中..." });
    setTimeout(function () {
                messages.pop();
                messages.push({
                sender: "bot",
                text: "您可點選活動→活動詳細→購票資訊→購買門票。",
                actions: [
                    {
                        type: "link",
                        label: "前往購票頁面",
                        url: "http://localhost:5173/EventCardView",
                    },
                ],
            }as MessageWithActions);
            }, 1000);
    
}



function sendProductInfo() {
    messages.push({ sender: "user", text: "我想詢問周邊商品資訊。" });
    messages.push({ sender: "bot", text: "輸入中..." });
    setTimeout(function () {
                messages.pop();
                messages.push({sender: "bot", text: "瀏覽所有周邊商品請輸入「1」。",});}, 1000);
    setTimeout(function () {
                messages.push({sender: "bot", text: "查看購物車請輸入「2」。",});}, 2000);
    setTimeout(function () {
                messages.push({sender: "bot", text: "查詢訂單請輸入「3」。",});}, 3000);
}


function sendServiceInfo() {
    messages.push({ sender: "user", text: "我想聯絡真人客服。" });           
            messages.push({ sender: "bot", text: "輸入中..." });

            setTimeout(function () {
                messages.pop();
                messages.push({ sender: "bot", text: "您可來信 YoungArtist2023@gmail.com 聯繫真人客服。" });
            }, 1000);
}


</script>
  
<template>    
            <div class="service">
                <!-- <h1 class="title">聞意青年客服系統</h1> -->
                <div class="common-layout">
            </div>
                <div id="app">
                    <div id="chatbox">
                        <a style="margin-left:40px;">歡迎使用本服務，請選擇您需要的服務。</a>
                        <div class="ActivityOptions" style="margin-left:40px;">
                            <el-button round @click="sendActivityInfo">活動資訊</el-button>
                            <el-button round @click="sendTicketInfo">購票資訊</el-button>
                            <el-button round @click="sendProductInfo">周邊商品資訊</el-button>
                            <el-button round @click="sendServiceInfo">聯絡真人客服</el-button>
                        </div>

                        <div v-for="message in messages" >
                            <div v-if="message.sender === 'bot'" style="display:flex;justify-content:start"><span class="bot">{{ message.text }}</span></div>
                            <div v-else style="display:flex;justify-content:end"><span  class="user">{{ message.text }}</span></div>
                        </div>

                        <div class="ActivityOptions">
                        <el-button round v-show="ActivityOptions" @click="handleActivityOptionClick">查看所有活動</el-button>
                        <el-button round v-show="ActivityOptions" @click="handleActivityOptionClick">活動最新消息</el-button>
                        <el-button round v-show="ActivityOptions" @click="handleActivityOptionClick">活動詳細資訊</el-button>
                        </div>
                    </div>

                <el-affix  position="bottom" :offset="20" style=" background-color:white;"> 
                    <el-divider />
                <div class="input-box">
                                  
                    <span><input type="text" v-model="newMessage" @keyup.enter="sendMessage" placeholder="請輸入訊息"/></span>
                    <span><el-button round @click="sendMessage">送出</el-button></span>&nbsp;  
                    <!-- <span><el-button round @click="resetMessages">清空訊息</el-button></span> -->
                    
                </div>
                </el-affix>               

                </div>
            </div>
</template>




<style  scoped>

.service {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: baseline;
}

#app {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    position: relative;
    background-color: white;

}

#chatbox {
    width: 535px;
    height:700px;
    /* border-bottom: 1px solid rgb(169, 169, 169); */
    overflow-y: scroll;
    /* padding: 10px; */
    position: relative;
    /* background-color: white; */
}

.bot {
    text-align: left;
    margin-top: 10px;
    margin-bottom: 10px;
    border:1px solid rgb(169, 169, 169);
    border-radius: 20px;
    padding:7px;
}

.user {
    text-align: right;
    margin-bottom: 10px;
    margin-top: 10px;
    border:1px solid rgb(169, 169, 169);
    border-radius: 20px;
    padding:7px;
}
.ActivityOptions{
    margin-top: 15px;
}


input[type="text"] {
/* width: 300px; */
border:1px solid rgb(169, 169, 169);
border-radius: 20px;
padding: 10px;
font-size: 16px;
margin-right: 10px;
}


#app > div:last-child {
flex-direction: column;

}

.input-box{
    display: flex;
    flex-direction: row;
    justify-content:center;
    align-items: center;
    margin-bottom: 10px;
   
}

.button-container{
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    margin-top: 10px;
    background-color: white;
    
}
</style>