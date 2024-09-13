// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SupplyChainTracking {
    // Struct representing a product
    struct Product {
        string productName;
        uint256 productId;
        address manufacturer;
        address currentOwner;
        string status; // Status of the product (e.g., 'Manufactured', 'In Transit', 'Delivered')
    }

    // State variables
    address public admin; // Supply chain admin
    uint256 public productCounter; // Counter to assign product IDs
    mapping(uint256 => Product) public products; // Mapping to store products by productId
    mapping(uint256 => string[]) public productHistory; // Tracks the history of the product's status

    // Events for tracking
    event ProductManufactured(uint256 productId, address manufacturer);
    event ProductOwnershipTransferred(uint256 productId, address from, address to, string status);
    event ProductStatusUpdated(uint256 productId, string status);

    // Modifier to restrict actions to the admin only
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    // Modifier to restrict actions to the current owner of the product
    modifier onlyProductOwner(uint256 _productId) {
        require(products[_productId].currentOwner == msg.sender, "Not authorized");
        _;
    }

    // Constructor to set the admin (e.g., the supply chain owner)
    constructor() {
        admin = msg.sender;
    }

    // Function to manufacture a new product
    function manufactureProduct(string memory _productName) public onlyAdmin {
        productCounter++; // Increment product counter for new productId
        uint256 newProductId = productCounter;

        // Create a new product
        products[newProductId] = Product({
            productName: _productName,
            productId: newProductId,
            manufacturer: msg.sender,
            currentOwner: msg.sender,
            status: "Manufactured"
        });

        // Record product history
        productHistory[newProductId].push("Manufactured");

        // Emit an event for product manufacturing
        emit ProductManufactured(newProductId, msg.sender);
    }

    // Function to transfer product ownership (e.g., manufacturer -> distributor -> retailer)
    function transferOwnership(uint256 _productId, address _newOwner, string memory _newStatus) public onlyProductOwner(_productId) {
        Product storage product = products[_productId];
        address previousOwner = product.currentOwner;

        // Update the product's current owner and status
        product.currentOwner = _newOwner;
        product.status = _newStatus;

        // Record product history
        productHistory[_productId].push(_newStatus);

        // Emit an event for product ownership transfer
        emit ProductOwnershipTransferred(_productId, previousOwner, _newOwner, _newStatus);
    }

    // Function to update the product status (e.g., 'In Transit', 'Delivered', etc.)
    function updateProductStatus(uint256 _productId, string memory _status) public onlyProductOwner(_productId) {
        Product storage product = products[_productId];

        // Update product status
        product.status = _status;

        // Record product history
        productHistory[_productId].push(_status);

        // Emit an event for product status update
        emit ProductStatusUpdated(_productId, _status);
    }

    // Function to get the product's full history (transparent record of all changes)
    function getProductHistory(uint256 _productId) public view returns (string[] memory) {
        return productHistory[_productId];
    }

    // Function to view product details
    function getProductDetails(uint256 _productId) public view returns (string memory, address, address, string memory) {
        Product memory product = products[_productId];
        return (product.productName, product.manufacturer, product.currentOwner, product.status);
    }
}
