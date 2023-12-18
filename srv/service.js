const cds = require('@sap/cds/lib')

module.exports = class AdminService extends cds.ApplicationService {
	init() {
		this.before('NEW', 'Authors', genid)
		this.before('NEW', 'Books', genid)
		this.on("CREATE", "Books", createBook);
		return super.init()
	}
}

/** Generate primary keys for target entity in request */
async function genid(req) {
	const { ID } = await cds.tx(req).run(SELECT.one.from(req.target).columns('max(ID) as ID'))
	req.data.ID = ID - ID % 100 + 100 + 1
}

async function createBook(req) {

	let dbUIAggregation = await cds.tx(req).run(SELECT.from('sap.capire.bookshop.UIAggregations as A')
		.leftJoin('sap.capire.bookshop.UIElements2UIAggregations as A2')
		.on("A.ID = A2.uiAggregation_ID").where({ 'A2.uiElement_name': 'JSONView', "A2.uiElement_version": '1.96.0', "A.isEnabled": true }));

	console.log(dbUIAggregation);

	return {};
}



