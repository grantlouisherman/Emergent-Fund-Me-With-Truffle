pragma solidity ^0.4.6;
contract Chat {

    struct Message {
        uint id;
        string content;

    }
    bytes32 [] messages;
    Message [] messageLog;
    uint messagesLength;
    
    function Chat(bytes32 [] startingMessages){
        messages = startingMessages;
        for(uint i =0;i<startingMessages.length;i++){
            addMessage(bytes32ToString(startingMessages[i]));
        }
    }


    event MessageAdded(uint id, string content);
  
    function addMessage(string content) {
        messageLog.push(Message(messagesLength,content));
        MessageAdded(messagesLength,content);
        messagesLength++;  
    }

    function getMessage(uint index) returns (string){
        return messageLog[index].content;
    }

   function bytes32ToString(bytes32 x) constant returns (string) {
        bytes memory bytesString = new bytes(32);
        uint charCount = 0;
        for (uint j = 0; j < 32; j++) {
            byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
            if (char != 0) {
                bytesString[charCount] = char;
                charCount++;
            }
        }
        bytes memory bytesStringTrimmed = new bytes(charCount);
        for (j = 0; j < charCount; j++) {
            bytesStringTrimmed[j] = bytesString[j];
        }
        return string(bytesStringTrimmed);
  }

}