export interface ticketOrderInterface {
    orderId: number;
    eventId?: number;
    area: string;
    seatId?: number;
    customerId?: number;
    price?: number;
}
// 訂單明細的介面
export interface dataType {
    orderId: number,
    orderState: number,
    orderStateString: string,
    orderTotalPrice: number,
    orderCreateTimestamp: string,
    orderUpdateTimestamp: string,
    detail: boolean,
    pop: boolean,
    dataType_detail: dataType_detail[]
}
// 詳細訂單的介面
export interface dataType_detail {
    area: string,
    eventId: number,
    eventName: string,
    orderId: number,
    seatId: number,
}