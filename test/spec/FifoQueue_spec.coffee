
# Imports
FifoQueue = require('../../lib/FifoQueue').FifoQueue


describe "FifoQueue", ->

    queue = null

    beforeEach ->
        queue = new FifoQueue()

    afterEach ->
        queue = null

    it 'should start with empty queue', ->

        expect(queue.getCount()).toEqual(0)


    describe 'add objects to queue', ->

        it 'should add one object to the queue', ->

            queue.push "hello world"

            expect(queue.getCount()).toEqual(1)

        it 'should not add null to the queue', ->

            queue.push null

            expect(queue.getCount()).toEqual(0)

        it 'should add more than one object to the queue', ->

            queue.push "hello world"

            queue.push "sausages"

            expect(queue.getCount()).toEqual(2)


    describe 'returning queue item status', ->

        it 'should return true if queue has items', ->

            queue.push "hello world"

            expect(queue.hasItems()).toBeTruthy()

        it 'should return true if queue has items', ->

            expect(queue.hasItems()).toBeFalsy()


    describe 'retrieve objects from queue', ->

        it 'should return objects with first in first out order', ->

            testObject1 = "foo"
            testObject2 = "hello world"
            testObject3 = "i'll be back"

            queue.push testObject1
            queue.push testObject2
            queue.push testObject3

            expect(queue.getItem()).toEqual(testObject1)
            expect(queue.getItem()).toEqual(testObject2)
            expect(queue.getItem()).toEqual(testObject3)

        it 'should remove objects from queue after returning', ->

            testObject1 = "foo"
            testObject2 = "hello world"

            queue.push testObject1
            queue.push testObject2

            expect(queue.getCount()).toEqual(2)

            queue.getItem()

            expect(queue.getCount()).toEqual(1)

            queue.getItem()

            expect(queue.getCount()).toEqual(0)

        it 'should throw exception when queue empty', ->

            expect(->

                queue.getItem()

            ).toThrow 'Queue empty, ensure not empty by using FifoQueue.hasItems().'
            

