import { useState } from 'react';
import { PixelStreamingWrapperUser } from './PixelStreamingWrapperUser';
import { PixelStreamingWrapperVendor } from './PixelStreamingWrapperVendor';
import { Button, Flex, Typography } from 'antd';

const boxStyle: React.CSSProperties = {
    width: '100%',
    height: '100%',
  };
const titleStyle: React.CSSProperties = {
    color: '#bbb',
    margin: '10px',
    position: 'absolute',
};
const { Title } = Typography;
  
export const App = () => {
    
    const [ userType, setUserType] = useState('');
    
    return (
        <div
            style={{
                height: '100%',
                width: '100%',
                backgroundImage: 'linear-gradient(#fff, #aaa)'
            }}
        >
            
            
            {userType === '' && (
                <>
                    <Title style={titleStyle}>Watchmaker experience</Title>
                    <Flex style={boxStyle} justify={'space-evenly'} align={'center'} gap="small" wrap="wrap">
                        <Button onClick={() => setUserType('User')}>User</Button>
                        <Button onClick={() => setUserType('Vendor')}>Vendor</Button>
                    </Flex>
                </>
            )}
            
            {userType === 'User' && (
            <PixelStreamingWrapperUser
                initialSettings={{
                    AutoPlayVideo: true,
                    AutoConnect: true,
                    ss: 'ws://localhost:90/?PlayerType=User',
                    StartVideoMuted: true,
                    HoveringMouse: true,
                    WaitForStreamer: true,
                }}
            />
            )}
            {userType === 'Vendor' && (
            <PixelStreamingWrapperVendor
                initialSettings={{
                    AutoPlayVideo: true,
                    AutoConnect: true,
                    ss: 'ws://localhost:90/?PlayerType=Vendor',
                    StartVideoMuted: true,
                    HoveringMouse: true,
                    WaitForStreamer: true
                }}
            />
            )}
            
        </div>
    );
};
