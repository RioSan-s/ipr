<?php
namespace App\RPC\V1;

    use OV\JsonRPCAPIBundle\Core\Annotation\JsonRPCAPI;
    use App\RPC\V1\Products\GetProductsRequest;
    use App\RPC\V1\Products\GetProductsResponse;

    /**
     *
     * @JsonRPCAPI(methodName = "getProducts")
     */
#[JsonRPCAPI(methodName: 'getProducts')]
class GetProductsMethod
{
    /**
     * @param GetProductsRequest $request
     * @return GetProductsResponse
     */
    public function call(GetProductsRequest $request): GetProductsResponse
    {
        // здесь осуществляете всю логику вашего метода API
        $id = $request->getId();
        return new GetProductsResponse($request->getTitle().'OLOLOLOLO');
    }
}
