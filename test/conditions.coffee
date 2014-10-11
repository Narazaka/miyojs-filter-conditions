chai = require 'chai'
chai.should()
expect = chai.expect
sinon = require 'sinon'
property_filter = require 'miyojs-filter-property'
MiyoFilters = require '../conditions.js'

describe 'caller', ->
	ms = null
	request = null
	id = null
	stash = null
	filter = MiyoFilters.conditions
	beforeEach ->
		ms = sinon.stub()
		ms.call_entry = sinon.stub()
		ms.filters =
			property_handler: property_filter.property_handler
		property_filter.property_initialize.call ms,
			property_initialize:
				handlers: ['coffee', 'jse', 'js']
		request = sinon.stub()
		id = 'OnTest'
		stash = null
	it 'should return undefined with no conditions', ->
		ret = filter.call ms, {}, request, id, stash
		expect(ret).is.undefined
		ms.call_entry.callCount.should.be.equal 0
	it 'should work with true', ->
		filter.call ms,
			conditions: [
				{
					when: 1
					do: 'y'
				}
				{
					when: 1
					do: 'n'
				}
			]
			, request, id, stash
		ms.call_entry.lastCall.args[0].should.be.deep.equal 'y'
	it 'should return on no match', ->
		filter.call ms,
			conditions: [
				{
					when: 0
					do: 'n'
				}
			]
			, request, id, stash
		ms.call_entry.callCount.should.be.equal 0
	it 'should always take entry which has no "when"', ->
		filter.call ms,
			conditions: [
				{
					when: 0
					do: 'n'
				}
				{
					do: 'y'
				}
			]
			, request, id, stash
		ms.call_entry.lastCall.args[0].should.be.deep.equal 'y'
	it 'should work with code', ->
		filter.call ms,
			conditions: [
				{
					'when.jse': 'false'
					do: 'n1'
				}
				{
					'when.jse': 'id == "OnTest"'
					do: 'y'
				}
				{
					'when.jse': 'true'
					do: 'n2'
				}
			]
			, request, id, stash
		ms.call_entry.lastCall.args[0].should.be.deep.equal 'y'
	it 'should work with code alternative', ->
		filter.call ms,
			conditions: [
				{
					'when.jse': 'false'
					do: 'n1'
				}
				{
					when: 0
					do: 'n2'
				}
				{
					'when.jse': 'false'
					'when.coffee': 'id == "OnTest"'
					do: 'y'
				}
				{
					'when.jse': 'true'
					do: 'n3'
				}
			]
			, request, id, stash
		ms.call_entry.lastCall.args[0].should.be.deep.equal 'y'
