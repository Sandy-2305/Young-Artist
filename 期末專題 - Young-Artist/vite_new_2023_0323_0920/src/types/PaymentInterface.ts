export interface PaymentInterface {
    [key: string]: any;
    CheckMacValue: string,
    ChoosePayment: string,
    ClientRedirectURL: string,
    CustomField2: string,
    CustomField3: string,
    CustomField4: string,
    Email: string,
    EncryptType: string,
    ExpireDate: string,
    IgnorePayment: string,
    ItemName: string,
    MerchantID: string,
    MerchantTradeDate: string,
    MerchantTradeNo: string,
    OrderResultURL: string,
    PaymentInfoURL: string,
    PaymentType: string,
    ReturnURL?: string,
    TotalAmount: string,
    TradeDesc: string
}
