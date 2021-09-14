const Realities = artifacts.require('./Realities')
const Reward = artifacts.require('./RealityReward')


contract('Game', ([deployer, user1, user2]) => {
    let realities, reward 

    beforeEach(async () => {
        realities = await Realities.new()
        reward = await Reward.new(realities.address)
    })

    describe('ERC20 Details', () => {
        it('Checking token name', async () => {
          expect(await reward.name()).to.be.eq('RealityNFTCoin')
        })
        it('Checking token symbol', async () => {
            expect(await reward.symbol()).to.be.eq('RNFT')
        })
      })
})
