import { PlayerUserType } from '../types';
import { PlayerUserVip } from './PlayerUserVip';
import { PlayerVendorVip } from './PlayerVendorVip';
import { Button, Flex, Typography } from 'antd';
import React, { useState } from 'react';

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
  
export const MainPageVip = () => {
    
    const [ playerUserType, setPLayerUserType] = useState('');
    
    return (
        <div
            style={{
                height: '100%',
                width: '100%',
                backgroundImage: 'linear-gradient(#fff, #aaa)'
            }}
        >
            
            
            {playerUserType === '' && (
                <>
                    <Title style={titleStyle}>Watchmaker VIP experience</Title>
                    <Flex style={boxStyle} justify={'space-evenly'} align={'center'} gap="small" wrap="wrap">
                        <Button onClick={() => setPLayerUserType(PlayerUserType.USER_VIP)}>User</Button>
                        <Button onClick={() => setPLayerUserType(PlayerUserType.VENDOR_VIP)}>Vendor</Button>
                    </Flex>
                </>
            )}
            
            {playerUserType === PlayerUserType.USER_VIP && (
            <PlayerUserVip
                initialSettings={{
                    AutoPlayVideo: true,
                    AutoConnect: true,
                    ss: 'wss://localhost:90/?PlayerUserType=' + PlayerUserType.USER_VIP,
                    StartVideoMuted: true,
                    HoveringMouse: true,
                    WaitForStreamer: true,
                }}
            />
            )}
            {playerUserType === PlayerUserType.VENDOR_VIP && (
            <PlayerVendorVip
                initialSettings={{
                    AutoPlayVideo: true,
                    AutoConnect: true,
                    ss: 'wss://localhost:90/?PlayerUserType=' + PlayerUserType.VENDOR_VIP,
                    StartVideoMuted: true,
                    HoveringMouse: true,
                    WaitForStreamer: true
                }}
            />
            )}
            
        </div>
    );
};
