// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract AIModelMarketplace {
    IERC20 public token; // Reference to the ERC20 token

    struct Model {
        uint256 id;
        string name;
        string description;
        uint256 price;
        address creator;
        uint256 totalRating;
        uint256 ratingCount;
        bool isSold;
        string fileLink;
    }

    Model[] public models;
    mapping(address => uint256) public earnings;

    event ModelListed(uint256 modelId, string name, uint256 price, address creator, string fileLink);
    event ModelPurchased(uint256 modelId, address buyer);
    event ModelRated(uint256 modelId, uint8 rating);

    constructor(address _tokenAddress) {
        token = IERC20(_tokenAddress);

        models.push(Model(1, "TextGPT", "It is AI like ChatGPT. Lorem ipsum dolor sit amet consectetur adipisicing elit.", 1600 * 10 ** 18, msg.sender, 19, 6, false, "none"));
        models.push(Model(2, "ImageGenAI", "AI that generates images. Lorem ipsum dolor sit amet consectetur.", 2000 * 10 ** 18, msg.sender, 18, 4, false, "none"));
        models.push(Model(3, "VoiceAssistAI", "AI for voice assistance. Lorem ipsum dolor sit amet.", 50 * 10 ** 18, msg.sender, 10, 6, false, "none"));
    }

    // List a new model
    function listModel(string memory name, string memory description, uint256 price, string memory fileLink) public {
        require(price > 0, "Price must be greater than zero.");
        require(bytes(fileLink).length > 0, "File path required.");

        models.push(Model({
            id: models.length,
            name: name,
            description: description,
            price: price * 10 ** 18,
            creator: msg.sender,
            totalRating: 0,
            ratingCount: 0,
            isSold: false,
            fileLink: fileLink
        }));

        emit ModelListed(models.length - 1, name, price, msg.sender, fileLink);
    }

    // Purchase a model using the ERC20 token
    function purchaseModel(uint256 modelId) public {
        require(modelId < models.length, "Model does not exist.");
        Model storage model = models[modelId];
        require(model.creator != msg.sender, "Creator cannot purchase their own model.");
        require(token.balanceOf(msg.sender) >= model.price, "Insufficient balance.");

        // Transfer the price to the creator
        token.transferFrom(msg.sender, model.creator, model.price);
        model.isSold = true;

        emit ModelPurchased(modelId, msg.sender);
    }

    // Rate a model between 1 and 5
    function rateModel(uint256 modelId, uint8 rating) public {
        require(modelId < models.length, "Model does not exist.");
        Model storage model = models[modelId];
        require(rating >= 1 && rating <= 5, "Rating must be between 1 and 5.");

        model.totalRating += rating;
        model.ratingCount++;

        emit ModelRated(modelId, rating);
    }

    // Withdraw earnings from selling models
    function withdrawFunds() public {
        uint256 amount = earnings[msg.sender];
        require(amount > 0, "No funds to withdraw.");

        earnings[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }

    // View model details
    function getModelDetails(uint256 modelId) public view returns (string memory name, string memory description, uint256 price, address creator, uint256 averageRating, bool isSold) {
        require(modelId < models.length, "Model does not exist.");

        Model storage model = models[modelId];
        averageRating = model.ratingCount > 0 ? (model.totalRating * 10) / model.ratingCount : 0;

        return (model.name, model.description, model.price, model.creator, averageRating, model.isSold);
    }

    function totalModels() public view returns (uint256) {
        return models.length;
    }
}
