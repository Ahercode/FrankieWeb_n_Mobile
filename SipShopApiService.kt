package net.sipconsult.siprestaurantpos.data.network

import net.sipconsult.siprestaurantpos.data.models.*
import net.sipconsult.siprestaurantpos.data.network.response.*
import okhttp3.Interceptor
import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.http.*
import java.util.concurrent.TimeUnit

interface SipShopApiService {

    @Headers("Content-Type: application/json")
    @GET("api/CompanyIfo/{id}")
    suspend fun getCompanyInfoAsync(@Path("id") id: Int = 0): CompanyInfoItem

    @Headers("Content-Type: application/json")
    @GET("api/ProductCategories")
    suspend fun getProductCategoriesAsync(): ProductCategories

    @Headers("Content-Type: application/json")
    @GET("api/Products")
    suspend fun getProductsAsync(): Products

    @Headers("Content-Type: application/json")
    @GET("api/Products/Category/{categoryId}")
    suspend fun getProductsCategoryAsync(@Path("categoryId") categoryId: Int): Products

    @Headers("Content-Type: application/json")
    @GET("api/Locations")
    suspend fun getLocationsAsync(): Locations

    @Headers("Content-Type: application/json")
    @GET("api/PaymentMethods")
    suspend fun getPaymentMethodsAsync(): PaymentMethods

    @Headers("Content-Type: application/json")
    @GET("api/Vouchers/{code}")
    suspend fun getVoucherAsync(@Path("code") code: String): VoucherResponse

    @POST("api/Employees/Authenticate")
    suspend fun authenticateAsync(@Body signInBody: SignInBody): LoginResponse

    @Headers("Content-Type: application/json")
    @GET("api/Clients")
    suspend fun getClientsAsync(): Clients

    @Headers("Content-Type: application/json")
    @GET("api/DiscountTypes")
    suspend fun getDiscountTypesAsync(): DiscountTypes

    @Headers("Content-Type: application/json")
    @POST("api/SalesTransactions")
    suspend fun postTransactionAsync(@Body body: SaleTransactionPostBody): TransactionResponse

    @Headers("Content-Type: application/json")
    @POST("api/Orders")
    suspend fun postOrderAsync(@Body body: OrderPostBody): TransactionResponse

    @Headers("Content-Type: application/json")
    @POST("api/SalesTransactions/refund")
    suspend fun postRefundTransactionAsync(@Body body: RefundTransactionPostBody): TransactionResponse

    @Headers("Content-Type: application/json")
    @GET("api/SalesTransactions/{transactionId}")
    suspend fun getTransactionAsync(@Path("transactionId") transactionId: Int): SalesTransactionsItem

    @Headers("Content-Type: application/json")
    @GET("api/SalesTransactions/operator/{operatorId}")
    suspend fun getTransactionsAsync(@Path("operatorId") operatorId: String): SalesTransactions

    @Headers("Content-Type: application/json")
    @GET("api/SalesTransactions/Location/{locationId}")
    suspend fun getLocationTransactionsAsync(@Path("locationId") locationId: Int): SalesTransactions

    @GET("api/SalesAgent")
    suspend fun getSalesAgentsAsync(): SalesAgents

    companion object {
        operator fun invoke(
            connectivityInterceptor: ConnectivityInterceptor
        ): SipShopApiService {
            val requestInterceptor = Interceptor { chain ->
                val url = chain.request()
                    .url()
                    .newBuilder()
                    .addQueryParameter("key", "API_KEY")
                    .build()
                val request = chain.request()
                    .newBuilder()
                    .url(url)
                    .build()
                return@Interceptor chain.proceed(request)
            }

            val okHttpClient = OkHttpClient.Builder()
                .addInterceptor(connectivityInterceptor)
                .connectTimeout(60, TimeUnit.SECONDS)
                .writeTimeout(60, TimeUnit.SECONDS)
                .readTimeout(60, TimeUnit.SECONDS)
                .build()

/*
            val gson = GsonBuilder()
                .setLenient()
                .create()
*/

            return Retrofit.Builder()
                .client(okHttpClient)
                .baseUrl("https://app.sipconsult.net/SipRestaurantApi/")
                .addConverterFactory(GsonConverterFactory.create())
                .build()
                .create(SipShopApiService::class.java)
        }
    }
}