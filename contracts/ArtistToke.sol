pragma solidity ^0.5.16;
contract Artist {
    // Collection of artworks by this Artist
    mapping(uint256 => ArtWork) artworks;
    address artist;

    constructor() public {
        artist = msg.sender;
    }

    function createArtwork(uint256 hashIPFS, string memory Name)
        public
        returns (ArtWork)
    {
        ArtWork artContract = new ArtWork(hashIPFS, Name, artist);
        artworks[hashIPFS] = artContract;
        return artContract;
    }

    function checkArtwork(uint256 hashIPFS) public view returns (bool) {
        if (artworks[hashIPFS] == ArtWork(0x0)) {
            return false;
        }
        return true;
    }
}

contract ArtWork {
    // Detail of artwork
    address artist;
    string name;
    uint256 hashIPFS;
    address owner;

    constructor(uint256 ipfsHash, string memory artName, address originalOwner)
        public
    {
        artist = msg.sender;
        name = artName;
        hashIPFS = ipfsHash;
        owner = originalOwner;
    }

    function setOwner(address newOwner) public {
        if (owner == msg.sender) {
            owner = newOwner;
        }
    }
}
