/* How Master Contract Moves:
    Owner Address (Used to index for each user)
        List of Document Contracts (Appends new Document Contract for every upload based on IPFS hash) (Used to search/view all documents on main search page)
            Document Contract (Has its own contract address and name for each document on blockchain)
                Document Revisions/Versions w/ Hashes (Used to download from IPFS based on hash stored)
                
 */
import "./DocumentContract.sol";

contract MasterContract {
    address constant private serverAddress = 0xE0f5206BBD039e7b0592d8918820024e2a7437b9;
    modifier onlyOwner(){
        require(msg.sender == serverAddress);
        _;
    }

    //ownerAddress => documentContracts
    mapping(address => address[]) public owners;

    //Using owner address grab List of Document Contracts
    function getListOfDocuments(address owner) public view returns(address[] memory){
        return owners[owner];
    }
    //Function needed to take IPFS hash and make new Document Contract (FOR UPLOAD)

    //Note: Add in onlyOwner modifier
    function uploadDocument(string memory ipfsHash, address ownerAddress, string memory documentName) public{
        owners[ownerAddress].push(
            address(new DocumentContract(ipfsHash, ownerAddress, documentName))
            );
    }

    //Function for revision

    //Function needed to get all or specifically searched document contracts from specified owner (FOR SEARCH/VIEWING)
    //Note: Add in onlyOwner modifier
    function getContractsByOwner(address ownerAddress) public view returns(address[] memory){
        return owners[ownerAddress];
    }

    //Note: Add in onlyOwner modifier
    //Deletion
    function deleteOwnerFromDocument(address owner, address document) public{
        address[] memory documentAddresses = owners[owner];
        for(uint i = 0; i < documentAddresses.length; i++){
            if(documentAddresses[i] == document){
                documentAddresses[i] = documentAddresses[documentAddresses.length - 1];
                delete documentAddresses[documentAddresses.length - 1];
                break;
            }
        }

        owners[owner] = documentAddresses;
    }
}
